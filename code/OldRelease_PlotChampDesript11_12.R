library(ellipse)

##############################################################
# User Inputs (if I make this a function, will pass these
# in as function arguments
##############################################################
# specify the metric you want to plot a scatter plot against -
# right now we'll plot against "SiteLength" and "Gradient"
	scatterplot.x.vars = c("SiteLength", "SiteWaterSurfaceGradient") #, "IntegratedBankfullWidth")
# Name of data file for the MetricsDataDictionary.csv
	dictionary.name = "MetricsDataDictionary.csv"
# Name of file containting data
	datafile.name = "MetricsAndCovariates_CHaMP_FinalWorkshop_20121116.csv"

#####################################################################

# create a "plots" folder to store results
dir.create("Plots",showWarnings = FALSE)

# import data dictionary as a matrix
# filter dictionary.mtrx to only include visit-level 
# metrics and to exclude channel unit-level metrics
# These are coded in the data dictionary "DsipalyGroupID" and "IsDisplayable"
# being set to 1


	dictionary.mtrx <- read.table(dictionary.name, header=T, sep=",") 
	dictionary.mtrx <- dictionary.mtrx[dictionary.mtrx$DisplayGroupID == 1,] 
	dictionary.mtrx <- dictionary.mtrx[dictionary.mtrx$IsDisplayable == 1,]

# some cleanup done here to remove spaces and dashes, which don't
# play well as R data names.  In R, these names will differ slightly
# from the names in the data file names.  The original names will
# be saved as text strings in "DisplayNameFull", to be used for plot titles, etc.

	dictionary.mtrx$DisplayNameFull = dictionary.mtrx$DisplayName
dictionary.mtrx$DisplayName


	dictionary.mtrx$DisplayName <- gsub(" ", "", dictionary.mtrx$DisplayName)
	dictionary.mtrx$DisplayName <- gsub("-", "", dictionary.mtrx$DisplayName)

dictionary.mtrx$DisplayName
# Read the Metrics Data
      metrics.mtrx <- read.csv(datafile.name, header=T)
names(metrics.mtrx)


# changed 11-9-12 (M@)
names(metrics.mtrx) <-gsub(pattern="\\." ,"", names(metrics.mtrx))
names(metrics.mtrx) <-gsub("-","", names(metrics.mtrx))
#names(metrics.mtrx) <-gsub(".","", names(metrics.mtrx))

#	metrics.mtrx <- read.table(datafile.name, header=T, sep=",")
	dimnames(metrics.mtrx)[[2]] <- gsub("Fast.", "Fast", dimnames(metrics.mtrx)[[2]])
names(metrics.mtrx)
nrow(metrics.mtrx)
metrics.mtrx$SiteWaterSurfaceGradient

# Population.col.names indicate group from which subpopulations are plotted.
# i.e. if Population.col.names[1] = "Watershed", then the subgroups will
# be the watershed names.
# Initially we have only watershed as a population subgroup... right now the
# code is only set of for one Poputlation type... ultimately can add more
# if desired.

	Population.col.names = dictionary.mtrx$DisplayName[dictionary.mtrx$MetricType == "Population Identifier"]
	Population.col.names
	n.populations = length(Population.col.names)
	n.populations


#Get the column index in the dataset that matches the population.col.name
# for example - what column number in the data file is "Watershed"

	Population.col.index = match(Population.col.names[1], names(metrics.mtrx))
	Population.col.index

# set the subgroups names (Population.levels)
	metrics.mtrx$Population = metrics.mtrx[, Population.col.index]
	Population.levels = levels(metrics.mtrx$Population)
	metrics.mtrx$Population
	Population.levels




# only set up to do 1 strata identifier right now.
# Could do more if needed and we specified what we wanted plotted by what.
	Strata.col.names = 
		dictionary.mtrx$DisplayName[
		dictionary.mtrx$MetricType == "Strata Identifier"][1]
	Strata.col.names
# Get the column names for the Strata identifier column in the data file
	Strata.col.index = match(Strata.col.names[1], names(metrics.mtrx))
	Strata.col.index 
	metrics.mtrx$Strata = metrics.mtrx[, Strata.col.index]
	metrics.mtrx$Strata

# Now we have our watersheds, and all the strata within the watershed.
# Time to start looping through and making plots for each watershed

k=2
k=1
###################################################
###################################################
# Set up population /  subgroup levels to plot  
# First go through all watershed (population identifier),
# then go tharough once more with all levels and group by watershed

	for (k in 1:(length(Population.levels)+1)) {

	if (k==(length(Population.levels)+1)) {
# Use all the data.  I.e. first time through we'll plot over all watershed,
# and subgroup by watershed
	      metrics = metrics.mtrx
		subgroup = metrics$Population
	      subgroups = levels(factor(subgroup))
		folder = "All_Data"
	      Title = "All_Watersheds"
	      dictionary = dictionary.mtrx
	      subgroup.label = "Watershed"
	} else {
# Use data for only one sub-population (i.e. one watershed) at a time
# and subgroup by strata	 
        pop.name = Population.levels[k]
	  metrics = metrics.mtrx[metrics.mtrx[,Population.col.index]==pop.name,]
		  dictionary = dictionary.mtrx
		   subgroup = metrics$Strata
		   subgroups = levels(factor(metrics$Strata))
		   Title = Population.levels[k]
		  folder = gsub(" ","", Population.levels[k])
		  subgroup.label = "Strata"
}

######################
########################################################


#First lets make the correlation plots

names(dictionary)

cor.cat = 
factor(na.omit(dictionary$MetricCategory[dictionary$ShowGraphForWatershed==1]))
cor.cat

metrics.to.plot = factor(na.omit(dictionary$DisplayName[dictionary$ShowGraphForWatershed==1]))
names(metrics)
levels(cor.cat)


for (i in 1:nlevels(cor.cat))
{

print(levels(cor.cat)[i])

cor.metrics = factor(metrics.to.plot[cor.cat==levels(cor.cat)[i]])
cor.metrics

if (length(cor.metrics) > 1) {

cor.metrics
names(metrics)

match(cor.metrics, names(metrics))

cor.index = na.omit(
match(as.character(cor.metrics),names(metrics))
)

cor.index
as.character(cor.metrics)


match(as.character(cor.metrics),names(metrics))
cor.metrics
names(metrics)

#cor.index
#metrics[,cor.index]

metrics[,cor.index]
cor.index
xc=cor(metrics[,cor.index],use='pairwise.complete.obs', method='spearman')
metrics[,cor.index]

colors = c("#A50F15","#DE2D26","#FB6A4A","#FCAE91","#FEE5D9","white","#EFF3FF","#BDD7E7","#6BAED6","#3182BD","#08519C")
colors = colors[length(colors):1]

dir.create(paste("Plots/",folder, sep=""),showWarnings = FALSE)
png(paste("Plots/",folder,"/CorrPlot",levels(cor.cat)[i],".png",sep=""),
 8,6, units='in', res=300)

plotcorr(xc, cex.lab=0.8, col=colors[5*xc + 6], 
  main=paste(Title,": ", levels(cor.cat)[i], sep=""))


dev.off()

}
}



i=56
################################################
## Now make other plots for each site....

	for (i in 1: nrow(dictionary)) {

# check to see if "ShowGraphForWatersehd is equal to one (i.e. graphs turned on for this)
	dictionary$ShowGraphForWatershed[i]
	if (is.na(dictionary$ShowGraphForWatershed[i])==FALSE) {
	 if (dictionary$ShowGraphForWatershed[i]==1) {

# comment out later
#par(mfrow=c(2,2))


	metric.name.full = as.character(dictionary$DisplayNameFull[i])
	metric.name = gsub(" ", "", metric.name.full)
	metric.name
	metric.names = names(metrics)
	metric.names

# find the column index for the metric to be plotted
	index=match(metric.name, metric.names)
	print(paste(i, metric.name, index))

# make some plots
# check that a valid index was returned (i.e. it found a matching column in the
# metrics to the metric specified by the data dictionary
	if (is.na(index)==FALSE) {

# and make sure we've got something numeric to plot
	if (is.numeric(metrics[,index])) {

# Skip plot if not data
	if (length(na.omit(metrics[,index])) != 0 ) {

# re-use later
	dir.create(paste("Plots/",folder, sep=""),showWarnings = FALSE)

	#paste("Plots/",folder,"/",metric.name,".png",sep="")
# for 3 x 1 plots
#	png(paste("Plots/",folder,"/",metric.name,".png",sep=""),
#	 10,4, units='in', res=300)
#      op = par(mfrow=c(1,3), oma=c(2,0,2,0))

# for 2 x 2 plots (4 plots total, added 11/12/12 
	png(paste("Plots/",folder,"/",metric.name,".png",sep=""),
	 10,10, units='in', res=300)
	op = par(mfrow=c(2,2), oma=c(2,0,2,0), mar=c(12,4,4,2))


#plot a histogram
	hist(metrics[,index], main="Histogram", col="cyan", xlab="")

#make some boxplot(s)

#for (j in 1:length(subgroup)) {
#subgroup.index = match(subgroups[j], metric.names)
	 ylimits = c(min(na.omit(metrics[, index])), max(na.omit(metrics[, index])))
	 boxplot( metrics[,index] ~ factor(subgroup), ylim=ylimits,
	    las=2, axes=F, main=paste("By", subgroup.label), col="cyan")
# manually add all the parts on the boxplot
	box()
	axis(2)
	subgroups
	nlevels(factor(subgroup))
	axis(1, cex.axis=0.7, at=1:nlevels(factor(subgroup)), labels=subgroups, las=2)
	abline(h=mean(metrics[,index], na.rm=T), col=2, lty=2)
	mtext('n =', at=0.2, col=4, cex=0.8)

#cbind(metrics[,index], factor(subgroup))

# count only points with data, not NA, for "n=" for each boxplot
nlevels(subgroup)


n.noNA = rep(0, nlevels(factor(subgroup)))
for (z in 1: nlevels(factor(subgroup))) {
 n.noNA[z] = length(na.omit(metrics[,index][subgroup==levels(factor(subgroup))[z]]))
}

n.noNA

#cbind(subgroup,metrics[,index])
#n.noNA
#subgroup
#table(factor(subgroup[is.na(metrics[,index])==FALSE]))
#table(factor(subgroup))

table(factor(subgroup))
n.noNA
#	mtext(table(factor(subgroup)), 
#	at=1:nlevels(factor(subgroup)), col=4, cex=0.8)

# replace above with this to deal with NA's
      mtext(n.noNA, at=1:length(n.noNA), col=4, cex=0.6)


# } only using 1 subgroup catagory

### make scatter plots.
	 for (k in 1:length(scatterplot.x.vars)) {
		scatterplot.x = scatterplot.x.vars[k]
		xindex = match(scatterplot.x,names(metrics))
		scatterplot.xdata = metrics[, xindex]

# if all x data is na, set it all to zero to avoid plot error
if(length(na.omit(scatterplot.xdata))==0) {
   scatterplot.xdata=rep(0, length(scatterplot.xdata)) }

		plot(scatterplot.xdata, metrics[, index], 
		main = paste("Vs", scatterplot.x.vars[k])
		, xlab = scatterplot.x.vars[k], ylab=metric.name.full, pch=19, col=1)

		metric.name.full
		mtext(
		gsub('.', ' ', paste(Title, ": ", metric.name.full, sep=""), fixed=T),
		, outer=T, cex=1.6, font=2)

	}

### save for later
	par(op)
	dev.off()



# My favorite line of code:
}}}}}}}



##################################################################
##################################################################

# Add a bunch more "all_watershed" plots per Carol's 11/12/12 request
	      metrics = metrics.mtrx
		subgroup = metrics$Population
	      subgroups = levels(factor(subgroup))
		folder = "All_Data/Addtional Plots"
	      Title = "All_Watersheds"
	      dictionary = dictionary.mtrx
	      subgroup.label = "Watershed"

dir.create(paste("Plots/",folder, sep=""),showWarnings = FALSE)



############################################
png(paste("Plots/",folder,"/","BankfullLargeWoodFrequency_vs_WettedLargeWoodVolumebySite",".png",sep=""),
6,6, units='in', res=300)
with(metrics,
plot(BankfullLargeWoodFrequencyper100m, WettedLargeWoodFrequencyper100m,
main="Bankfull Large Wood Frequency vs. 
Wetted Large Wood Frequency",
 xlab = "Bankfull Large Wood Frequency per 100m",
 ylab = "Wetted Large Wood Frequency per 100m",
 pch = 19, col = "black"))
dev.off()

##############################################
png(paste("Plots/",folder,"/","BankfullLargeWoodVolumebySite_vs_WettedLargeWoodVolumebySite",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullLargeWoodVolumebySite, WettedLargeWoodVolumebySite,
main="Bankfull Large Wood Volume by Site vs. 
Wetted Large Wood Volume by Site",
 xlab = "Bankfull Large Wood Volume by Site",
 ylab = "Wetted Large Wood Volume by Site",
pch = 19, col = "black"))
dev.off()

##############################################
png(paste("Plots/",folder,"/","BankfullLargeWoodVolumeInPools_vs_WettedLargeWoodVolumeInPools",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullLargeWoodVolumeinPools, WettedLargeWoodVolumeinPools,
main="Bankfull Large Wood Volume in Pools vs. 
Wetted Large Wood Volume in Pools",
 xlab = "Bankfull Large Wood Volume in Pools",
 ylab = "Wetted Large Wood Volume in Pools",
pch = 19, col = "black"))
dev.off()

##############################################
png(paste("Plots/",folder,"/","BankfullWidthProfileFilteredCV_vs_WettedWidthProfileFilteredCV",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullWidthProfileFilteredCV, WettedWidthProfileFilteredCV,
main="Bankfull Width Profile Filtered CV vs. 
Wetted Width Width Profile Filtered CV",
 xlab = "Bankfull Profile Filtered CV",
 ylab = "Wetted Width Profile Filtered CV",
pch = 19, col = "black"))
dev.off()

##############################################
png(paste("Plots/",folder,"/","BankfullWidthProfileFilteredMean_vs_WettedWidthProfileFilteredMean",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullWidthProfileFilteredMean, WettedWidthProfileFilteredMean,
main="Bankfull Width Profile Filtered Mean vs. 
Wetted Width Profile Filtered Mean",
 xlab = "Bankfull Profile Filtered Mean",
 ylab = "Wetted Width Profile Filtered Mean",
pch = 19, col = "black"))
dev.off()


##############################################
png(paste("Plots/",folder,"/","BankfullWidthToDepthRatioProfileFilteredCV_vs_WettedWidthToDepthRatioProfileFilteredCV",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullWidthToDepthRatioProfileFilteredCV, WettedWidthToDepthRatioProfileFilteredCV,
main="Bankfull Width to Depth Ratio Profile Filtered CV vs. 
Wetted Width to Depth Ratio Profile Filtered CV",
 xlab = "Bankfull Width to Depth Ratio Profile Filtered CV",
 ylab = "Wetted Width to Depth Ratio Profile Filtered CV",
pch = 19, col = "black"))
dev.off()

##############################################
png(paste("Plots/",folder,"/","BankfullWidthToDepthRatioProfileFilteredMean_vs_WettedWidthToDepthRatioProfileFilteredMean",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(BankfullWidthToDepthRatioProfileFilteredMean, WettedWidthToDepthRatioProfileFilteredMean,
main="Bankfull Width to Depth Ratio Profile Filtered Mean vs. 
Wetted Width to Depth Ratio Profile Filtered Mean",
 xlab = "Bankfull Width to Depth Ratio Profile Filtered Mean",
 ylab = "Wetted Width to Depth Ratio Profile Filtered Mean",
pch = 19, col = "black"))
dev.off()

##############################################
## Don't have a "Bankfull Volume" ???
#png(paste("Plots/",folder,"/","BankfullVolume_vs_WettedVolume",".png",sep=""),
#6,6, units='in', res=300)
#with (metrics,
#plot(BankfullVolume, WettedVolume,
#main="Bankfull Volume vs. Wetted Volume",
# xlab = "Bankfull Volume",
# ylab = "Wetted Volume",
#pch = 19, col = "black"))
#dev.off()
##############################################
png(paste("Plots/",folder,"/","SiteDischarge_vs_WettedWidthProfileFilteredMean",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(SiteDischarge, WettedWidthProfileFilteredMean,
main="Site Discharge vs Wetted Width Profile Filtered Mean",
 xlab = "Site Discharge",
 ylab = "Wetted Width Profile Filtered Mean",
 pch = 19, col = "black"))
	dev.off()

##############################################
png(paste("Plots/",folder,"/","SiteMeasurementofAlkalinity_vs_SiteMeasurementofConductivity",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(SiteMeasurementofAlkalinity,SiteMeasurementofConductivity ,
main="Site Measurement of Alkalinity vs
Site Measurement of Conductivity",
 xlab = "Alkalinity",
 ylab = "Conductivity",
 pch = 19, col = "black"))
	dev.off()
##############################################
png(paste("Plots/",folder,"/","PoolArea_vs_PoolVolume",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(PoolArea, PoolVolume,
main="Pool Area vs Pool Volume",
 xlab = "Pool Area",
 ylab = "Pool Volume",
 pch = 19, col = "black"))
	dev.off()
##############################################
png(paste("Plots/",folder,"/","PoolArea_vs_PoolFrequency",".png",sep=""),
6,6, units='in', res=300)
with (metrics,
plot(PoolArea, PoolFrequency,
main="Pool Area vs Pool Frequency",
 xlab = "Pool Area",
 ylab = "Pool Frequency",
 pch = 19, col = "black"))
	dev.off()

###
	par(op)
	dev.off()


