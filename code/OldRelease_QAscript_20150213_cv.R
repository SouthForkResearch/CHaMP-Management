# Author: Kevin See
# Purpose: Produce tables and plots to help QA CHaMP data
# Created: 9/8/2014
# Last Modified: 2/11/2015
# Notes: Combines year-to-year plots that Kevin See worked on, and within year plots that Matt Nahorinak developed
# 9.23.14: fixed some bugs and added some descriptive statistics at the end. Would like to use data dictionary, but the file needs to be updated with metric names that match those coming from CM.org
# 10.7.14: added capability to read in metric names from data dictionary file Carol put together. Uses appropriate display names from data dictionary for plot titles and axis labels
# 11.21.14: used updated data dictionary and CHaMP data that Carol sent me directly
# 11.25.14: changed the one-stage variance decomposition function to better deal with GRTS weights of repeat sites
# 12.01.14: created tables to capture stats behind the annual plots and repeat plots

# the libraries needed
# run this line if you don't have these packages already installed, then run the proceeding lines to load them into your workspace
# install.packages(c('plyr', 'gdata', 'ggplot2', 'gridExtra', 'reshape', 'RColorBrewer'))

library(plyr)
library(gdata)
library(ggplot2)
library(gridExtra)
library(reshape)
library(RColorBrewer)

#----------------------------------------
# need to update working directory, directory where CM.org data is stored, directory where data dictionary is stored
#----------------------------------------
# set working directory - make sure you point it where you want these plots stored
setwd('/Users/SFR5/Documents/RWorkspace/CHaMP_QA_2014')
#setwd('/Users/kevin/Dropbox/ISEMP/Analysis_Projects/CHaMP_metrics/QA_Test_20150211')

# folder where data from CM.org is stored
#cm.dir = '/Users/kevin/Dropbox/ISEMP/Analysis_Projects/CHaMP_metrics/QA_Test_20150211/'
cm.dir = '/Users/SFR5/Documents/RWorkspace/CHaMP_QA_2014/'
# name of file with CHaMP data
# cm.name = 'CHaMPQA_2011_2014_20150211.xlsx'
cm.name = 'CHaMPQA_2011_2014_20150307.csv'

# Name of data file for the MetricsDataDictionary.csv
# dictionary.name = "MetricsDataDictionary20150121.xlsx"
dictionary.name = "MetricsDataDictionary_20150211.csv"
# path where dictionary is stored
#dictionary.dir = '/Users/kevin/Dropbox/ISEMP/Analysis_Projects/CHaMP_metrics/QA_Test_20150211/'
dictionary.dir = '/Users/SFR5/Documents/RWorkspace/CHaMP_QA_2014/'
# set up group of metrics to plot against each other
met.vs.met.tab = read.csv('MetricComparison.csv')

#------------------------------------------#
# Some functions you'll need for plotting  #
#------------------------------------------#
# function to remove unused levels from a dataset
RmLevels = function(df) {
  data.class = sapply(as.list(df), class)
  facs = names(data.class)[which(data.class=='factor')]
  for(i in facs) {
    tab = table(df[,i])
    levels(df[,i])[tab==0] = NA
  }
  return(df)
}

# this function is for use with the pairs function
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
  if(length(x) == 1 | length(y) == 1) return(NULL)  
  usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y, use='pairwise.complete.obs'))
    txt <- format(c(r, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(cex.cor)) cex <- 0.8/strwidth(txt)

    test <- cor.test(x,y)
    # borrowed from printCoefmat
    Signif <- symnum(test$p.value, corr = FALSE, na = FALSE,
                  cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                  symbols = c("***", "**", "*", ".", " "))

    text(0.5, 0.5, txt, cex = cex * r)
    text(.7, .8, Signif, cex=cex, col=2)
}

# this function makes a plot of annual sites against each other
AnnualPlot = function(met, my.data) {
  # met is the metric of interest
  # data is the dataset to use
  comp.data = reshape(subset(my.data, PanelName=='Annual' & Primary.Visit=='Yes', c('SiteName', 'VisitYear', met)), v.names=met, timevar='VisitYear', idvar='SiteName', direction='wide')
  comp.data = comp.data[rowSums(!is.na(comp.data[,-1]))>=2,]
  if(sum(colSums(is.na(comp.data))==nrow(comp.data))>0) comp.data = comp.data[,-which(colSums(is.na(comp.data))==nrow(comp.data))]
  if(nrow(comp.data)==0 | ncol(comp.data)<3) stop(paste('Data cannot generate plot for', met))
  pairs(comp.data[,-1], xlim = range(comp.data[,-1], na.rm=T), ylim=range(comp.data[,-1], na.rm=T), 
        lower.panel=panel.cor, 
        upper.panel=function(x,y,...) {
          points(x,y)
          abline(0,1, lty=2, col='red')
        },
        diag.panel=function(x, ...) {
          usr <- par("usr"); on.exit(par(usr))
          par(usr = c(usr[1:2], 0, 1.5) )
          h = hist(x, breaks=20, plot=F)
          breaks <- h$breaks; nB <- length(breaks)
          y <- h$counts; y <- y/max(y)
          rect(breaks[-nB], 0, breaks[-1], y, col = "lightblue", ...)
        },
        labels=gsub(paste0(met, '.'), '', names(comp.data)[-1]), cex.labels=1.2, main=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]))
}

# function for number of observations 
give.n <- function(x){
  return(c(y = Inf, label = sum(!is.na(x)))) 
}

# function to create boxplots of metric for annual sites within a watershed, colored by valley class, and then by strata
WatershedAnnualPlot = function(met, my.data, wtsd) {
  # pull out data for one watershed
  plot.data = RmLevels(subset(my.data, WatershedName==wtsd))
  if(sum(is.na(plot.data[,met]))==nrow(plot.data)) stop(paste("All", met, "values are NA in", wtsd))
  
  # create plot color coded by valley class
  p = ggplot(plot.data, aes(x=SiteName, y=plot.data[,met])) +
    geom_boxplot(aes(fill=ValleyClass)) +
    scale_color_brewer(name='Valley Class', palette='Set1') +
    theme_bw() +
    theme(legend.position='bottom', axis.text.x=element_text(angle=90, vjust=0.5)) +
    scale_y_continuous(limits=range(plot.data[,met], na.rm=T)*c(1, 1.05)) +
    stat_summary(fun.data=give.n, geom='text', vjust=1.5) +
    labs(x='Site', y=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]), title=wtsd)
  
  # create plot color coded by strata
  p2 = ggplot(plot.data, aes(x=SiteName, y=plot.data[,met])) +
    geom_boxplot(aes(fill=CategoryName)) +
    scale_color_brewer(name='Strata', palette='Set1') +
    theme_bw() +
    theme(legend.position='bottom', axis.text.x=element_text(angle=90, vjust=0.5)) +
    scale_y_continuous(limits=range(plot.data[,met], na.rm=T)*c(1, 1.05)) +
    stat_summary(fun.data=give.n, geom='text', vjust=1.5) +
    guides(fill=guide_legend(ncol=min(4, nlevels(plot.data$CategoryName)))) +
    labs(x='Site', y=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]), title=wtsd)
  
  return(list(VC.plot = p, Strata.plot = p2, plot.data=plot.data))
}

# function to plot visit 1 vs. visit 2 for 10% repeat visits
RepeatVisitPlot = function(met, my.data) {
  comp.data = reshape(subset(my.data, VisitNumber %in% c(1:2), c('VisitYear', 'ValleyClass', 'SiteYr', 'VisitNumber', met)), v.names=met, timevar='VisitNumber', idvar='SiteYr', direction='wide')
  names(comp.data)[4:5] = c('Visit.1', 'Visit.2')
  p = ggplot(comp.data, aes(x=Visit.1, y=Visit.2)) +
    geom_point(aes(shape=as.factor(VisitYear), color=ValleyClass)) +
    geom_abline(intercept=0, slope=1, lty=2, col='darkgray') +
    theme_bw() +
    scale_shape_manual(name='Year', values=c(1, 17, 8, 10)[1:nlevels(as.factor(comp.data$VisitYear))]) +
    scale_color_brewer(name='Valley Class', palette='Set1') +
    labs(x='Visit 1', y='Visit 2', title=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]))
  return(p)
}

# function to make 4 within year plots 
WithinYearPlot = function(met, boxplot.title='By Watershed', main.title=NULL) {
	
	p1 = ggplot(plot.data, aes(x= plot.data[,met])) +
      geom_histogram(fill='cyan', col='black', binwidth=max(0.01, diff(range(plot.data[,met], na.rm=T))/30)) +
      theme_bw() +
      labs(x='', title='Histogram')
    
  p2 = ggplot(plot.data, aes(y= plot.data[,met], x=plot.data[,boxplot.catg])) +
    geom_boxplot(fill='cyan') +
    theme_bw() +
    theme(axis.text.x=element_text(angle=90, vjust=0.5, size=7)) +
    scale_y_continuous(limits=range(plot.data[,met], na.rm=T)*c(1, 1.1)) +
    stat_summary(fun.data=give.n, geom='text', vjust=1.5) +
    geom_hline(aes(yintercept=mean(plot.data[,met], na.rm=T)), color='red', lty=2) +
    labs(y='', x='', title=boxplot.title)
  
  p3 = ggplot(plot.data, aes(x=SiteLength, y= plot.data[,met])) +
    geom_point() +
    theme_bw() +
    labs(x='Site Length', y=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]), title='Vs. Site Length')
  
  p4 = ggplot(plot.data, aes(x=Grad, y= plot.data[,met])) +
    geom_point() +
    theme_bw() +
    labs(x='Site Water Surface Gradient', y=with(data.dictionary, DisplayName[match(met, DisplayNameShort)]), title='Vs. Surface Gradient')
  
	p = suppressWarnings(arrangeGrob(p1, p2, p3, p4, ncol=2, main=main.title))
  return(p)
}

#-------------------------------------
# Read in data dictionary
#------------------------------------- 
# data.dictionary <- read.xls(paste0(dictionary.dir, dictionary.name), header=T)
data.dictionary <- read.csv(paste0(dictionary.dir, dictionary.name), header=T, skip=2)
data.dictionary = data.dictionary[,grep('^X', names(data.dictionary), invert=T)]

#-------------------------------------
# read in CHaMP data
#-------------------------------------
# metrics = read.xls(paste0(cm.dir, cm.name))
metrics = read.csv(paste0(cm.dir, cm.name))

# change a few names to match data.dictionary
names(metrics)[match(c('SinuosityViaCenterline', 'FishCoverLW', 'FishCovLWUcut', 'LWVol_WetBfTurb'), names(metrics))] = c('Sin_CL', 'FishCovLW', 'FishCovUcut', 'LWVol_BfFstTurb')

names(metrics)[!names(metrics) %in% data.dictionary$DisplayNameShort]

# add column for site ID plus year
metrics$SiteYr = with(metrics, paste(SiteName, VisitYear, sep='.'))
# drop trailing spaces from some subbasin names
levels(metrics$WatershedName) = gsub(' $', '', levels(metrics$WatershedName))
# put in reasonable order
metrics = metrics[with(metrics, order(SiteName, VisitYear, as.Date(VisitDate, format='%d-%b-%y'))),]

#----------------------------------------------------------------
# pull out subsets of data, using Primary.Visit whenever possible
#----------------------------------------------------------------
# Core data - used to generate summary statistics
core.data = RmLevels(subset(metrics, CHaMP.Core=='Yes' & Primary.Visit=='Yes'))

# Annual panel data
annual.data = RmLevels(subset(metrics, PanelName =='Annual' & Primary.Visit=='Yes'))

# 10% repeat visits
rep.data = RmLevels(subset(metrics, CHaMP.10..Revisit =='Yes'))

# data for variance decomposition
var.decomp.data = RmLevels(subset(metrics, Visit.Status=='Released to Public' & WatershedName %in% unique(WatershedName[CHaMP.Core=='Yes'])))

# core.wtsds = c('Entiat', 'Wenatchee', 'Methow', 'John Day', 'Tucannon', 'Lemhi', 'South Fork Salmon', 'Upper Grande Ronde')
# var.decomp.data = RmLevels(subset(metrics, Visit.Status=='Released to Public' & WatershedName %in% core.wtsds))

#----------------------------------------------------------------
# Here's the list of metrics to test things on
#----------------------------------------------------------------
# use data dictionary, remove any blanks
met.nms = data.dictionary$DisplayNameShort[which(data.dictionary$DisplayNameShort!='')]
# remove GCD metrics for now
# met.nms = met.nms[grep('GCD', met.nms, invert=T)]

# make sure all metric names are in metrics file
table(met.nms %in% names(metrics))
# met.nms[!met.nms %in% names(metrics)]
# names(metrics)[!names(metrics) %in% met.nms]
# pull out the ones that are in the metrics file
met.nms = met.nms[met.nms %in% names(metrics)]
length(met.nms)
met.nms = as.character(met.nms)

#---------------------------------------------------------------------
# Create file structure and set directories where plots will be stored
#---------------------------------------------------------------------
qa.dir = 'QAfolder'
if(!file.exists(qa.dir)) dir.create(file.path(getwd(), qa.dir))
qa.1yr = paste0(qa.dir, '/WithinYearPlots')
if(!file.exists(qa.1yr)) dir.create(file.path(getwd(), qa.1yr))

for(yr in unique(metrics$VisitYear)) {
  if(!file.exists(paste0(qa.1yr, '/', yr))) {
    dir.create(file.path(getwd(), paste0(qa.1yr, '/', yr)))
    dir.create(file.path(getwd(), paste0(qa.1yr, '/', yr, '/AllChamp')))
    dir.create(file.path(getwd(), paste0(qa.1yr, '/', yr, '/EachWatershed')))
  }
}

qa.ann = paste0(qa.dir, '/AnnualSitePlots')
if(!file.exists(qa.ann)) dir.create(file.path(getwd(), qa.ann))
qa.allcm = paste0(qa.ann, '/AllChamp')
if(!file.exists(qa.allcm)) dir.create(file.path(getwd(), qa.allcm))
qa.wtsd = paste0(qa.ann, '/EachWatershed')
if(!file.exists(qa.wtsd)) dir.create(file.path(getwd(), qa.wtsd))

qa.rep = paste0(qa.dir, '/RepeatVisitPlots')
if(!file.exists(qa.rep)) dir.create(file.path(getwd(), qa.rep))
qa.add = paste0(qa.dir, '/AdditionalPlots')
if(!file.exists(qa.add)) dir.create(file.path(getwd(), qa.add))

qa.stats = paste0(qa.dir, '/Statistics')
if(!file.exists(qa.stats)) dir.create(file.path(getwd(), qa.stats))

qa.var.decomp = paste0(qa.dir, '/VarianceDecomposition')
if(!file.exists(qa.var.decomp)) dir.create(file.path(getwd(), qa.var.decomp))

#------------------------------------------------
# To save files of data that went into the plots
data.dir = paste0(qa.dir, '/Data')
if(!file.exists(data.dir)) dir.create(file.path(getwd(), data.dir))

# save data
write.csv(core.data, file=paste0(data.dir, '/CoreSites.csv'), row.names=F)
write.csv(annual.data, file=paste0(data.dir, '/AnnualSites.csv'), row.names=F)
write.csv(rep.data, file=paste0(data.dir, '/RepeatSites.csv'), row.names=F)
#------------------------------------------------


############################
##     Create plots       ##
############################

#----------------------------------------------------------------
# Year-to-year plots on annual sites
#----------------------------------------------------------------
# annual sites
for(met in met.nms) {
  if(sum(is.na(annual.data[,met]))==nrow(annual.data)){
  	cat(paste(met, 'are all NA in all years \n'))
  	next
  }
  if(sum(table(annual.data$VisitYear, !is.na(annual.data[,met]))[,'TRUE']!=0)<=1) {
  	which.yrs = unique(annual.data$VisitYear)[which(table(annual.data$VisitYear, !is.na(annual.data[,met]))[,'TRUE']==0)]
  	cat(paste(met, 'are all NA in', paste(which.yrs, collapse=', '), '\n'))
  	next
  }
  png(paste0(qa.allcm, '/', met, '_AnnualSites.png'))
  AnnualPlot(met, my.data=annual.data)
  dev.off()
}

#----------------------------------------------------------------
# Boxplots of annual sites within each watershed for each metric
# colored by valley class, and then by strata
#----------------------------------------------------------------
# create plot in watershed folder
for(wtsd in levels(annual.data$WatershedName)) {
  sub.dir = paste0(qa.wtsd, '/', wtsd, '/')
  if(!file.exists(sub.dir)) dir.create(file.path(getwd(), sub.dir))
  for(met in met.nms) {
    my.plots = try(WatershedAnnualPlot(met, annual.data, wtsd))
    # if no values to plot (all NA in that watershed), skip to next metric
    if(class(my.plots)=='try-error') next
    
    plot.data = my.plots[['plot.data']]
    
    # save plots
    ggsave(filename=paste0(met, '_AnnualSitesBoxPlot_ValleyClass.png'), plot=my.plots[['VC.plot']], path=sub.dir, width=13, height=7, units='in', dpi=75)        
    ggsave(filename=paste0(met, '_AnnualSitesBoxPlot_Strata.png'), plot=my.plots[['Strata.plot']], path=sub.dir, width=13, height=7, units='in', dpi=75)
        
    rm(my.plots, plot.data)   
  }
  rm(sub.dir)
}

#----------------------------------------------------------------
# Repeat visits - Visit 1 vs Visit 2
#----------------------------------------------------------------
# 10% repeat visits
for(met in met.nms) ggsave(filename=paste0(met, '_CHaMP_revists.png'), plot=RepeatVisitPlot(met, rep.data), path=qa.rep, width=7, height=7, units='in', dpi=75)

#----------------------------------------------------------------
# Within year visits (histogram, boxplots, scatter plots vs site length & gradient)
#----------------------------------------------------------------
for(yr in unique(metrics$VisitYear)) {
  yr.data = RmLevels(subset(metrics, VisitYear==yr))
  
  for(met in met.nms) {
  	if(sum(is.na(yr.data[,met]))==nrow(yr.data)) {
  	  cat(paste("All", met, "values are NA in", yr, '\n'))
  	  next
  	}
	plot.data = yr.data
    boxplot.catg = 'WatershedName'
  	my.plot = WithinYearPlot(met, main.title=paste('All Watersheds:', with(data.dictionary, DisplayName[match(met, DisplayNameShort)])))
  	ggsave(filename=paste0(met, 'CHaMP.', yr, '.png'), plot=my.plot, path=paste0(qa.1yr, '/', yr, '/AllChamp/'), width=13, height=7, units='in', dpi=75)        
    
    rm(my.plot, plot.data, boxplot.catg)
  }
    
  for(wtsd in unique(yr.data$WatershedName)) {
    wtsd.data = subset(yr.data, WatershedName==wtsd)
    if(nrow(wtsd.data)==0) next
    
    if(!file.exists(paste0(qa.1yr, '/', yr, '/EachWatershed/', wtsd))) dir.create(file.path(getwd(), paste0(qa.1yr, '/', yr, '/EachWatershed/', wtsd)))
    
    for(met in met.nms) {
  	  if(sum(is.na(wtsd.data[,met]))==nrow(wtsd.data)) {
  	    cat(paste("All", met, "values are NA in", yr, "for", wtsd, '\n'))
  	    next
  	  }
      
      plot.data = wtsd.data
  	  boxplot.catg = 'CategoryName'

    	my.plot = WithinYearPlot(met, boxplot.title='By Strata', main.title=paste0(wtsd, ': ', with(data.dictionary, DisplayName[match(met, DisplayNameShort)])))
      
  	  ggsave(filename=paste0(met, '.', yr, '.png'), plot=my.plot, path=paste0(qa.1yr, '/', yr, '/EachWatershed/', wtsd), width=13, height=7, units='in', dpi=75)        
    
      rm(my.plot, plot.data, boxplot.catg)
    }
  rm(wtsd.data)
  }
  rm(yr.data)
}

#----------------------------------------------------------------
# Plot selected metrics against other selected metrics
#----------------------------------------------------------------
for(i in 1:nrow(met.vs.met.tab)) {
  if(!met.vs.met.tab[i,1] %in% names(metrics)) {
    cat(paste('\n', met.vs.met.tab[i,1], 'not in metrics file \n'))
    next
  }
  if(!met.vs.met.tab[i,2] %in% names(metrics)) {
    cat(paste('\n', met.vs.met.tab[i,2], 'not in metrics file \n'))
    next
  }  
  cor.df = metrics[,match(c('SiteName', 'VisitYear', as.character(met.vs.met.tab[i,1]), as.character(met.vs.met.tab[i,2])), names(metrics))]
  names(cor.df)[3:4] = c('Metric.1', 'Metric.2')
  cor.tab = rbind(ddply(cor.df, .(VisitYear), summarize, r = cor(Metric.1, Metric.2, use='pairwise.complete.obs')), data.frame(VisitYear='All', r = with(cor.df, cor(Metric.1, Metric.2, use='pairwise.complete.obs'))))
  my.grob = grobTree(textGrob(label=paste('r =', round(cor.tab$r[nrow(cor.tab)], 2)), x=0.95, y=0.95, hjust=1, gp=gpar(fontsize=10)))
  
  p = ggplot(metrics, aes(x=metrics[,match(met.vs.met.tab[i,1], names(metrics))], y=metrics[,match(met.vs.met.tab[i,2], names(metrics))])) +
    geom_point(aes(shape=as.factor(VisitYear), color=as.factor(VisitYear))) +
    theme_bw() +
    scale_shape_discrete(name='Year               r', labels=with(cor.tab[-nrow(cor.tab),], paste(VisitYear, round(r, 2), sep='    '))) +
    scale_color_brewer(name='Year               r', labels=with(cor.tab[-nrow(cor.tab),], paste(VisitYear, round(r, 2), sep='    ')), palette='Set1') +
    annotation_custom(my.grob) +
    labs(x=met.vs.met.tab[i,1], y=met.vs.met.tab[i,2], title=paste(met.vs.met.tab[i,1], 'vs.\n', met.vs.met.tab[i,2]))
  
  ggsave(filename=paste0(met.vs.met.tab[i,1], '_vs_', met.vs.met.tab[i,2], '.png'), plot=p, path=qa.add, width=7, height=7, units='in', dpi=75)
  
  rm(p)  
}


#----------------------------------------------------------------
# Create descriptive summary statistics
#----------------------------------------------------------------
# transform core data into better format
met.melt = melt(core.data, measure.vars=met.nms, id.vars=c('SiteName', 'VisitYear', 'WatershedName', 'ValleyClass', 'CategoryName'), variable_name='Metric')
# to use display name for metrics in csv files
met.melt$Metric = data.dictionary$DisplayName[match(met.melt$Metric, data.dictionary$DisplayNameShort)]

# stats across whole data set
all.yr = ddply(met.melt, .(Metric), summarise,
	  WatershedName = 'All',
	  VisitYear = 'All',
	  n = length(value),
	  not.NA = sum(!is.na(value)),
	  is.NA = sum(is.na(value)), 
	  Mean = mean(value, na.rm=T),
      Std.Err.Mean = NA,
	  Std.Dev = sd(value, na.rm=T),
	  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
	  Median = median(value, na.rm=T),
    Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
    Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
    Trend = NA,
    Std.Err.Trend=NA)

# stats by year
by.yr = ddply(met.melt, .(Metric, VisitYear), summarise,
	  WatershedName = 'All',
	  n = length(value),
	  not.NA = sum(!is.na(value)),
	  is.NA = sum(is.na(value)), 
	  Mean = mean(value, na.rm=T),
	  Std.Err.Mean = NA,
	  Std.Dev = sd(value, na.rm=T),
	  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
	  Median = median(value, na.rm=T),
	  Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
	  Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
	  Trend = NA,
	  Std.Err.Trend=NA)

# stats by watershed and year
wtsd.yr = ddply(met.melt, .(Metric, WatershedName, VisitYear), summarise,
                n = length(value),
                not.NA = sum(!is.na(value)),
                is.NA = sum(is.na(value)), 
                Mean = mean(value, na.rm=T),
                Std.Err.Mean = NA,
                Std.Dev = sd(value, na.rm=T),
                CV = sd(value, na.rm=T) / mean(value, na.rm=T),
                Median = median(value, na.rm=T),
                Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
                Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
                Trend = NA,
                Std.Err.Trend=NA)

# stats by watershed
wtsd.all = ddply(met.melt, .(Metric, WatershedName), summarise,
	  VisitYear = 'All',
	  n = length(value),
	  not.NA = sum(!is.na(value)),
	  is.NA = sum(is.na(value)), 
	  Mean = mean(value, na.rm=T),
	  Std.Err.Mean = NA,
	  Std.Dev = sd(value, na.rm=T),
	  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
	  Median = median(value, na.rm=T),
	  Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
	  Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
	  Trend = NA,
	  Std.Err.Trend=NA)

# stats by valley class and year
vc.yr = ddply(met.melt, .(Metric, ValleyClass, VisitYear), summarise,
              n = length(value),
              not.NA = sum(!is.na(value)),
              is.NA = sum(is.na(value)), 
              Mean = mean(value, na.rm=T),
              Std.Err.Mean = NA,
              Std.Dev = sd(value, na.rm=T),
              CV = sd(value, na.rm=T) / mean(value, na.rm=T),
              Median = median(value, na.rm=T),
              Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
              Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
              Trend = NA,
              Std.Err.Trend=NA)

# stats by valley class
vc.all = ddply(met.melt, .(Metric, ValleyClass), summarise,
	  VisitYear = 'All',
	  n = length(value),
	  not.NA = sum(!is.na(value)),
	  is.NA = sum(is.na(value)), 
	  Mean = mean(value, na.rm=T),
	  Std.Err.Mean = NA,
	  Std.Dev = sd(value, na.rm=T),
	  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
	  Median = median(value, na.rm=T),
	  Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
	  Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
	  Trend = NA,
	  Std.Err.Trend=NA)

# stats by strata (and watershed) and year
strata.yr = ddply(met.melt, .(Metric, WatershedName, CategoryName, VisitYear), summarise,
                  n = length(value),
                  not.NA = sum(!is.na(value)),
                  is.NA = sum(is.na(value)), 
                  Mean = mean(value, na.rm=T),
                  Std.Err.Mean = NA,
                  Std.Dev = sd(value, na.rm=T),
                  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
                  Median = median(value, na.rm=T),
                  Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
                  Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
                  Trend = NA,
                  Std.Err.Trend=NA)

# stats by strata (and watershed)
strata.all = ddply(met.melt, .(Metric, WatershedName, CategoryName), summarise,
	  VisitYear = 'All',
	  n = length(value),
	  not.NA = sum(!is.na(value)),
	  is.NA = sum(is.na(value)), 
	  Mean = mean(value, na.rm=T),
	  Std.Err.Mean = NA,
	  Std.Dev = sd(value, na.rm=T),
	  CV = sd(value, na.rm=T) / mean(value, na.rm=T),
	  Median = median(value, na.rm=T),
	  Min = ifelse(sum(is.na(value))<length(value), min(value, na.rm=T), NA),
	  Max = ifelse(sum(is.na(value))<length(value), max(value, na.rm=T), NA),
	  Trend = NA,
	  Std.Err.Trend=NA)

# write some .csv files
yr.stats = rbind(all.yr[,names(by.yr)], by.yr)
yr.stats = yr.stats[with(yr.stats, order(Metric, VisitYear)),]
write.csv(yr.stats, file=paste0(qa.stats, '/Stats_AllData.csv'), row.names=F)

wtsd.stats = rbind(wtsd.all[,names(wtsd.yr)], wtsd.yr)
wtsd.stats = wtsd.stats[with(wtsd.stats, order(Metric, WatershedName, VisitYear)),]
write.csv(wtsd.stats, file=paste0(qa.stats, '/Stats_By_Watershed.csv'), row.names=F)

vc.stats = rbind(vc.all[,names(vc.yr)], vc.yr)
vc.stats = vc.stats[with(vc.stats, order(Metric, ValleyClass, VisitYear)),]
write.csv(vc.stats, file=paste0(qa.stats, '/Stats_By_ValleyClass.csv'), row.names=F)

strata.stats = rbind(strata.all[,names(strata.yr)], strata.yr)
strata.stats = strata.stats[with(strata.stats, order(Metric, WatershedName, CategoryName, VisitYear)),]
write.csv(strata.stats, file=paste0(qa.stats, '/Stats_By_Strata.csv'), row.names=F)

#----------------------------------------------------------------
# Run variance decomposition
#----------------------------------------------------------------
library(foreign)
# read in frame info
frame.dir = '/Users/kevin/Dropbox/ISEMP/Data/DesignDocs/Frames/Frame Files/'
frame.nm = 'CHamp_Frames_All_20140902'

# frame.dir = '/Users/kevin/Dropbox/ISEMP/Data/DesignDocs/Frames/Frame Files/CHaMPsiteSnapped_20141120/CHaMP_Sites_Snapped_Proj_20141120/'
# frame.nm = 'CHaMP_Sites_Snapped_Proj_20141120'

frames = read.dbf(paste0(frame.dir, frame.nm, '.dbf'))

# km in each watershed by year and strata
strat.2011 = ddply(subset(frames, Target2011=='Target'), .(CHaMPshed, Strata2011), summarize, 
                   Year = 2011,
                   Length = sum(LengthKM))
names(strat.2011) = c('WatershedName', 'CategoryName', 'VisitYear', 'Strata.Length')
strat.2012 = ddply(subset(frames, Target2012=='Target'), .(CHaMPshed, Strata2012), summarize, 
                   Year = 2012,
                   Length = sum(LengthKM))
names(strat.2012) = c('WatershedName', 'CategoryName', 'VisitYear', 'Strata.Length')
strat.2013 = ddply(subset(frames, Target2013=='Target'), .(CHaMPshed, Strata2013), summarize, 
                   Year = 2013,
                   Length = sum(LengthKM))
names(strat.2013) = c('WatershedName', 'CategoryName', 'VisitYear', 'Strata.Length')
strat.all = rbind(strat.2011, strat.2012, strat.2013)
names(strat.all)

# read in file that contains correct strata for each site
champ.sites.all = read.xls('/Users/kevin/Dropbox/ISEMP/Data/DesignDocs/Frames/Frame Files/CHaMPsiteSnapped_20141120/CHaMP_Sites_Snapped_Proj_20141120.xlsx')
for(strat.col in c('Strata2011', 'Strata2012', 'Strata2013')) {
  levels(champ.sites.all[,strat.col]) = gsub('   Public Lands', '-Public', levels(champ.sites.all[,strat.col]))
  levels(champ.sites.all[,strat.col]) = gsub('   Private Lands', '-Private', levels(champ.sites.all[,strat.col]))  
}

with(var.decomp.data, table(SiteName %in% champ.sites.all$Site_ID))
# correct the strata names - use 2013 strata
var.decomp.data$CategoryName = champ.sites.all$Strata2013[match(var.decomp.data$SiteName, champ.sites.all$Site_ID)]

# transform variance decomposition data into better format
# var.decomp.melt = melt(var.decomp.data, measure.vars=met.nms, id.vars=c('Site.Name', 'VisitYear', 'WatershedName', 'ValleyClass', 'Category.Name'), variable_name='Metric')
var.decomp.melt = melt(var.decomp.data, measure.vars=met.nms, id.vars=c('SiteName', 'VisitYear', 'WatershedName', 'ValleyClass', 'CategoryName', 'Primary.Visit', 'CHaMP.10..Revisit'), variable_name='Metric')

# sites.df = merge(ddply(var.decomp.melt, .(Metric, WatershedName, CategoryName, VisitYear), summarize, n.sites = length(unique(SiteName[!is.na(value)]))), subset(strat.all, VisitYear==2013, c('WatershedName', 'CategoryName', 'Strata.Length')), all.x=T)
sites.df = merge(ddply(subset(var.decomp.melt, Primary.Visit=='Yes'), .(Metric, WatershedName, CategoryName, VisitYear), summarize, n.sites = length(unique(SiteName[!is.na(value)]))), subset(strat.all, VisitYear==2013, c('WatershedName', 'CategoryName', 'Strata.Length')), all.x=T)

sites.df$Adj.Wgt = with(sites.df, Strata.Length / n.sites)
sites.df$Adj.Wgt[sites.df$n.sites==0] = NA
# norm.wgt = ddply(sites.df, .(Metric, WatershedName, VisitYear), summarize,
  # n.sites = sum(n.sites),
  # TotalKM = sum(Strata.Length),
  # Norm.Wgt = Adj.Wgt / max(Adj.Wgt, na.rm=T))

# where and when are strata with missing strata length?
with(subset(sites.df, is.na(Strata.Length) & Metric=='Lgth_Bf'), table(WatershedName, VisitYear))
unique(subset(sites.df, is.na(Strata.Length), c('WatershedName', 'VisitYear', 'CategoryName', 'n.sites')))
unique(subset(sites.df, is.na(Adj.Wgt), c('WatershedName', 'VisitYear', 'CategoryName', 'n.sites')))


# add weights to variance decomposition melted dataframe
var.decomp.wgts = merge(var.decomp.melt, sites.df[,c('WatershedName', 'VisitYear', 'CategoryName', 'Metric', 'Strata.Length', 'n.sites', 'Adj.Wgt')])

# re-adjust weights for re-visited sites
with(var.decomp.wgts, table(table(paste(SiteName, VisitYear, Metric, sep='_'))))

visit.tab = ddply(var.decomp.wgts, .(SiteName, VisitYear, Metric), summarize, n.visits = length(SiteName))
var.decomp.wgts = merge(var.decomp.wgts, visit.tab)
head(var.decomp.wgts)

# my.data = subset(var.decomp.wgts, Metric=='Sin_CL')
# var.decomp.wgts.test = subset(var.decomp.wgts, Metric %in% c('SubD50', 'SlowWater_Area', 'Sin_CL'))

# function that does variance decomposition and returns some summary statistics from it
Var.Decomp = function(my.data, log.transf=T, rand.eff.all = c('VisitYear', 'WatershedName', 'ValleyClass', 'SiteName'), boot.wgts = T, n.boot=100, iterative.boot=T) {
  library(lme4)
	if(log.transf) my.data$mod.metric = log(my.data$value+0.1)
	if(!log.transf) my.data$mod.metric = my.data$value
	
  # what to return if there's an error with a particular metric
  return.df = data.frame(Year=NA, ValleyClass=NA, Watershed=NA, Site=NA, Measurement.Noise=NA)
  
	# possible random effects
	rand.eff = rand.eff.all	
  for(eff in rand.eff.all) if(length(unique(RmLevels(subset(my.data, !is.na(mod.metric)))[,eff]))<=1) rand.eff = rand.eff[-match(eff, rand.eff)]
	
	if(length(rand.eff)==0) {
		cat(paste('Not enough non-NA sites for', unique(my.data$Metric), '\n'))
# 		return(return.df)
    return(NULL)
	}
	
	mod.form = as.formula(paste('mod.metric ~ 1 + (1 |', paste(rand.eff, collapse=') + (1 | '), ')'))

# one version of incorporating GRTS weights
  if(boot.wgts & iterative.boot) {
    vars.df = NULL
    samp.data.org = subset(my.data, !is.na(Adj.Wgt))
    samp.data.org$Prob.Wgt = with(samp.data.org, (Adj.Wgt/n.visits) / sum(Adj.Wgt/n.visits))
    for(i in 1:n.boot) {
      if(i %% 10 == 0) cat(paste('Iteration', i, '\n'))
      samp.data = samp.data.org[sample(1:nrow(samp.data.org), nrow(samp.data.org), replace=T, prob = samp.data.org$Prob.Wgt),]
      mod = try(lmer(mod.form, samp.data))
      if(class(mod)=='try-error') {
        cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
        #   	return(return.df)
        return(NULL)
      }
      vars.df = rbind(vars.df, c(as.numeric(VarCorr(mod)), attr(VarCorr(mod), "sc")^2))
    }
    my.vars = colMeans(vars.df)
    names(my.vars) = c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')
  }

# a different version of incorporating GRTS weights
  if(boot.wgts & !iterative.boot) {
    samp.data.org = subset(my.data, !is.na(Adj.Wgt))
    samp.data.org$Prob.Wgt = with(samp.data.org, (Adj.Wgt/n.visits) / sum(Adj.Wgt/n.visits))
    samp.data = samp.data.org[sample(1:nrow(samp.data.org), n.boot*nrow(samp.data.org), replace=T, prob = samp.data.org$Prob.Wgt),]
    mod = try(lmer(mod.form, samp.data))
    if(class(mod)=='try-error') {
      cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
      #   	return(return.df)
      return(NULL)
    }
    # pull out variances
    my.vars = c(as.numeric(VarCorr(mod)), attr(VarCorr(mod), "sc")^2)
    names(my.vars) = c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')
  }

# not using GRTS weights
	if(!boot.wgts) {
    mod = try(lmer(mod.form, my.data))
  	if(class(mod)=='try-error') {
  		cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
  		#   	return(return.df)
  		return(NULL)
  	}	
  	# pull out variances
  	my.vars = c(as.numeric(VarCorr(mod)), attr(VarCorr(mod), "sc")^2)
  	names(my.vars) = c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')
	}

  return(data.frame(t(my.vars)))
}

# var.decomp.no.wgt = ddply(var.decomp.melt, .(Metric), Var.Decomp, boot.wgts=F)
# start.time = proc.time()
# var.decomp.with.wgt.v1 = ddply(var.decomp.wgts, .(Metric), Var.Decomp, boot.wgts=T, n.boot=100, iterative.boot=F)
# v1.time = proc.time() - start.time
# 
# start.time = proc.time()
# var.decomp.with.wgt.v2 = ddply(var.decomp.wgts, .(Metric), Var.Decomp, boot.wgts=T, n.boot=100, iterative.boot=T)
# v2.time = proc.time() - start.time
# 
# v1.time
# v2.time
# var.decomp.no.wgt
# var.decomp.with.wgt.v1
# var.decomp.with.wgt.v2


var.decomp.all.yr = ddply(var.decomp.wgts, .(Metric), Var.Decomp, boot.wgts=T, n.boot=100, iterative.boot=F)
# order the columns better for summary table
var.decomp.all.yr = var.decomp.all.yr[,c('Metric', 'Year', 'ValleyClass', 'Watershed', 'Site', 'Measurement.Noise')]
# change metric names to longer display names
var.decomp.all.yr$Metric = paste0('log(', data.dictionary$DisplayName[match(var.decomp.all.yr$Metric, data.dictionary$DisplayNameShort)], ')')
write.csv(var.decomp.all.yr, file=paste0(qa.var.decomp, '/VarianceDecomposition.csv'), row.names=F)

# add a few summary metrics
var.decomp.all.yr$RMSE = sqrt(var.decomp.all.yr$Measurement.Noise)
var.decomp.all.yr$S.N = rowSums(var.decomp.all.yr[,-c(1, nrow(var.decomp.all.yr))], na.rm=T) / var.decomp.all.yr$Measurement.Noise
var.decomp.all.yr$Rel.Precision = var.decomp.all.yr$RMSE / (with(all.yr, Max - Min))[match(var.decomp.all.yr$Metric, paste0('log(', data.dictionary$DisplayName[match(all.yr$Metric, data.dictionary$DisplayName)], ')'))]

hist(var.decomp.all.yr$Rel.Precision, 30, col='lightgray', main='CHaMP Metrics', xlab='Relative Precision')
abline(v=c(0.052, 0.15), col=c('darkgreen', 'red'))
# good metrics
subset(var.decomp.all.yr, Rel.Precision<=0.052)$Metric
# so-so metrics
subset(var.decomp.all.yr, Rel.Precision>0.052 & Rel.Precision<0.15)$Metric
# poor metrics
subset(var.decomp.all.yr, Rel.Precision>=0.15)$Metric

#---------------------------------------
# create bar plot of results
var.decomp.plot = var.decomp.all.yr[,1:6]
# have variances sum to 1
var.decomp.plot[,-1] = t(apply(var.decomp.plot[,-1], 1, function(x) x/sum(x)))
# do all rows sum to 1?
table(rowSums(var.decomp.plot[,-1]))

# melt data for plotting
vd.plot.melt = melt(var.decomp.plot, id.vars='Metric')
vd.plot.melt$Metric = factor(vd.plot.melt$Metric, levels = var.decomp.plot$Metric[order(var.decomp.plot$Measurement.Noise, decreasing=T)])

vd.plot = ggplot(vd.plot.melt, aes(x=Metric, y=value, fill=variable)) +
  geom_bar(stat='identity') +
  labs(x='Metric', y='Relative Variance', title='Variance Components') +
  theme_bw() +
  theme(legend.position='bottom') +
  scale_fill_brewer(palette='Set1') +
  coord_flip()

ggsave(filename='VarianceDecomp.png', plot=vd.plot, path=qa.var.decomp, width=12, height=20, units='in', dpi=75)


# #---------------------------------------------------
# # test 2-stage variance decomposition method
# #---------------------------------------------------
# # function that does variance decomposition using a two-stage method and returns some summary statistics from it
# Var.Decomp2 = function(my.data, log.transf=T, rand.eff.all = c('VisitYear', 'WatershedName', 'ValleyClass'), boot.wgts = T, n.boot=100, iterative.boot=T) {
#   library(lme4)
#   if(log.transf) my.data$mod.metric = log(my.data$value+0.1)
#   if(!log.transf) my.data$mod.metric = my.data$value
#   
#   # what to return if there's an error with a particular metric
#   return.df = data.frame(Year=NA, ValleyClass=NA, Watershed=NA, Site=NA, Measurement.Noise=NA)
#   
#   # possible random effects
#   rand.eff = rand.eff.all	
#   for(eff in rand.eff.all) if(length(unique(RmLevels(subset(my.data, !is.na(mod.metric)))[,eff]))<=1) rand.eff = rand.eff[-match(eff, rand.eff)]
#   
#   if(length(rand.eff)==0) {
#     cat(paste('Not enough non-NA sites for', unique(my.data$Metric), '\n'))
#     # 		return(return.df)
#     return(NULL)
#   }
#   
#   mod.form = as.formula(paste('mod.metric ~ 1 + (1 |', paste(rand.eff, collapse=') + (1 | '), ')'))
#   
#   # one version of incorporating GRTS weights
#   if(boot.wgts & iterative.boot) {
#     vars.df = NULL
#     samp.data.org = subset(my.data, !is.na(Adj.Wgt) & Primary.Visit=='Yes')
#     samp.rep.org = subset(my.data, !is.na(Adj.Wgt) & CHaMP.10..Revisit=='Yes')
#     for(i in 1:n.boot) {
#       if(i %% 10 == 0) cat(paste('Iteration', i, '\n'))
#       samp.data = samp.data.org[sample(1:nrow(samp.data.org), nrow(samp.data.org), replace=T, prob = samp.data.org$Adj.Wgt / sum(samp.data.org$Adj.Wgt)),]
#       samp.rep.data = samp.rep.org[sample(1:nrow(samp.rep.org), nrow(samp.rep.org), replace=T, prob = samp.rep.org$Adj.Wgt / sum(samp.rep.org$Adj.Wgt)),]
#       mod.1 = try(lmer(mod.form, samp.data))
#       # get measurement noise from 10% repeat visits
#       mod.2 = try(lmer(mod.metric ~ 1 + (1|SiteName), samp.rep.data))
#       
#       if(class(mod.1)=='try-error' | class(mod.2)=='try-error' ) {
#         cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
#         #   	return(return.df)
#         return(NULL)
#       }
#       # pull out variances
#       my.vars.1 = c(as.numeric(VarCorr(mod.1)), attr(VarCorr(mod.1), "sc")^2)
#       names(my.vars.1) = c(c('Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Site')
#       my.vars.2 = c(Site=as.numeric(VarCorr(mod.2)), Measurement.Noise=attr(VarCorr(mod.2), "sc")^2)
#       vars.df = rbind(vars.df, c(my.vars.1[1:(length(my.vars.1)-1)], Site=max(0, my.vars.1['Site'] - my.vars.2[2]), my.vars.2[2]))
#     }
#     my.vars = colMeans(vars.df)
#     my.vars = my.vars[c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')]
#   }
#   
#   # a different version of incorporating GRTS weights
#   if(boot.wgts & !iterative.boot) {
#     samp.data.org = subset(my.data, !is.na(Adj.Wgt) & Primary.Visit=='Yes')
#     samp.data.org$Prob.Wgt = with(samp.data.org, Adj.Wgt / sum(Adj.Wgt))
#     samp.data = samp.data.org[sample(1:nrow(samp.data.org), n.boot*nrow(samp.data.org), replace=T, prob = samp.data.org$Prob.Wgt),]
#     
#     samp.rep.org = subset(my.data, !is.na(Adj.Wgt) & CHaMP.10..Revisit=='Yes')
# 	samp.rep.org$Prob.Wgt = with(samp.rep.org, Adj.Wgt / sum(Adj.Wgt))
#     samp.rep = samp.rep.org[sample(1:nrow(samp.rep.org), n.boot*nrow(samp.rep.org), replace=T, prob = samp.rep.org$Prob.Wgt),]
#     
#     mod.1 = try(lmer(mod.form, samp.data))
#     # get measurement noise from 10% repeat visits
#     mod.2 = try(lmer(mod.metric ~ 1 + (1|SiteName), samp.rep))
#     if(class(mod.1)=='try-error' | class(mod.2)=='try-error' ) {
#       cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
#       #   	return(return.df)
#       return(NULL)
#     }
#     # pull out variances
#     my.vars.1 = c(as.numeric(VarCorr(mod.1)), attr(VarCorr(mod.1), "sc")^2)
#     names(my.vars.1) = c(c('Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Site')
#     my.vars.2 = c(Site=as.numeric(VarCorr(mod.2)), Measurement.Noise=attr(VarCorr(mod.2), "sc")^2)
#     my.vars = c(my.vars.1[1:(length(my.vars.1)-1)], Site=max(0, my.vars.1['Site'] - my.vars.2[2]), my.vars.2[2])
#     my.vars = my.vars[c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')]
#   }
# 
#   # not using GRTS weights
#   if(!boot.wgts) {
#     mod.1 = try(lmer(mod.form, my.data))
#     # get measurement noise from 10% repeat visits
#     mod.2 = try(lmer(mod.metric ~ 1 + (1|SiteName), subset(my.data, CHaMP.10..Revisit=='Yes')))
#     if(class(mod.1)=='try-error' | class(mod.2)=='try-error' ) {
#       cat(paste('Problem with lmer model for', unique(my.data$Metric), '\n'))
#       #     return(return.df)
#       return(NULL)
#     }
#     # pull out variances
#     my.vars.1 = c(as.numeric(VarCorr(mod.1)), attr(VarCorr(mod.1), "sc")^2)
#     names(my.vars.1) = c(c('Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Site')
#     my.vars.2 = c(Site=as.numeric(VarCorr(mod.2)), Measurement.Noise=attr(VarCorr(mod.2), "sc")^2)
#     my.vars = c(my.vars.1[1:(length(my.vars.1)-1)], Site=max(0, my.vars.1['Site'] - my.vars.2[2]), my.vars.2[2])
#     my.vars = my.vars[c(c('Site', 'Watershed', 'ValleyClass', 'Year')[rev(rand.eff.all) %in% rand.eff], 'Measurement.Noise')]
#   }
# 
#   return(data.frame(t(my.vars)))
# }
#   
# 
# var.decomp.all.yr2 = ddply(var.decomp.wgts, .(Metric), Var.Decomp2, boot.wgts=T, n.boot=100, iterative.boot=T)
# # order the columns better for summary table
# var.decomp.all.yr2 = var.decomp.all.yr2[,c('Metric', 'Year', 'ValleyClass', 'Watershed', 'Site', 'Measurement.Noise')]
# # change metric names to longer display names
# var.decomp.all.yr2$Metric = paste0('log(', data.dictionary$DisplayName[match(var.decomp.all.yr2$Metric, data.dictionary$DisplayNameShort)], ')')
# write.csv(var.decomp.all.yr2, file=paste0(qa.var.decomp, '/VarianceDecomposition_2stage.csv'), row.names=F)
# 
# 
# var.decomp.all.yr = read.csv(paste0(qa.var.decomp, '/VarianceDecomposition.csv'))
# var.decomp.all.yr2 = read.csv(paste0(qa.var.decomp, '/VarianceDecomposition_2stage.csv'))
# 
# identical(sort(var.decomp.all.yr$Metric), sort(var.decomp.all.yr2$Metric))
# table(var.decomp.all.yr2$Metric %in% var.decomp.all.yr$Metric)
# var.decomp.all.yr2 = var.decomp.all.yr2[which(var.decomp.all.yr2$Metric %in% var.decomp.all.yr$Metric),]
# op = par(mfrow=c(2,3))
# for(i in names(var.decomp.all.yr)[2:6]) {
# 	plot(var.decomp.all.yr[,i], var.decomp.all.yr2[,i], xlab='Full Model', ylab='Two-Step Model', main=i, xlim=range(c(var.decomp.all.yr[,i], var.decomp.all.yr2[,i]), na.rm=T), ylim=range(c(var.decomp.all.yr[,i], var.decomp.all.yr2[,i]), na.rm=T))
# 	abline(0,1, lty=2, col='darkred')
# }
# plot(rowSums(var.decomp.all.yr[,-1], na.rm=T), rowSums(var.decomp.all.yr2[,-1], na.rm=T), xlab='Full Model', ylab='Two-Step Model', main='Total Variance')
# abline(0,1, lty=2, col='darkred')
# par(op)
