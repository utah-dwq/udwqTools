#' Assign Utah beneficial use classes to sites
#'
#' This function assigns beneficial use classes to water quality portal type site objects (or data with site information attached).
#' @param x Input dataset. Must include latitude & longitude columns.
#' @param lat Name of latitude column. Default matches WQP objects.
#' @param long Name of longitude column. Default matches WQP objects.
#' @param flatten Logical. If FALSE (default), maintain use categorys as single comma separated column. If TRUE, use column and data are flattened by expanded use column.
#' @importFrom sf st_as_sf
#' @importFrom sf st_set_crs
#' @importFrom sf st_intersection
#' @importFrom reshape2 colsplit
#' @importFrom reshape2 melt
#' @examples 
#' # Read a couple of sites from Mantua Reservoir
#' sites=readWQP(type="sites", siteid=c("UTAHDWQ_WQX-4900440","UTAHDWQ_WQX-4900470"))
#' sites_uses=assignUses(sites)
#' sites_uses_flat=assignUses(sites, flatten=TRUE)

#' @export
assignUses=function(x, lat="LatitudeMeasure", long="LongitudeMeasure", flatten=FALSE){
	
	data(bu_poly)
	poly=sf::st_as_sf(bu_poly)
	
	x=sf::st_as_sf(x, coords=c(long,lat), crs=4326, remove=F)
	x=sf::st_set_crs(x, sf::st_crs(poly))	
	
	isect=suppressMessages({suppressWarnings({sf::st_intersection(x, poly)})})
	sf::st_geometry(isect)=NULL
	
	if(flatten){
		#Expand comma separated uses (bu_class)
		max_use_count=max(sapply(strsplit(as.character(isect$bu_class),","),FUN="length"))
		use_colnames=paste0(rep("use",max_use_count),seq(1:max_use_count))
		uses_mat=unique(data.frame(isect$bu_class,reshape2::colsplit(isect$bu_class,",",use_colnames)))
		names(uses_mat)[names(uses_mat)=="isect.bu_class"]="bu_class"
		
		#Flatten uses
		uses_flat=reshape2::melt(uses_mat, id.vars="bu_class", value.name = "BeneficialUse")
		uses_flat=uses_flat[,!names(uses_flat)=="variable"]
		uses_flat=uses_flat[uses_flat$BeneficialUse!="" & !is.na(uses_flat$BeneficialUse),]
		
		#Merge flat uses back to data by bu_class
		result=merge(isect,uses_flat,all=T)
		}else{
			result=isect
			names(result)[names(result)=="bu_class"]="BeneficialUse"
			}
			
return(result)

}


#bu_poly=sf::st_read("F:\\R\\udwqTools\\data","Beneficial_Uses_All_2020IR_wgs84")
#save(file="F:\\R\\udwqTools\\data\\bu_poly.rdata", bu_poly)


#leaflet::leaflet(x) %>%
#	leaflet::addTiles() %>%
#	leaflet::addProviderTiles("Esri.WorldTopoMap", group = "Topo") %>%
#	leaflet::addProviderTiles("Esri.WorldImagery", group = "Satellite") %>%
#	mapview::addFeatures(x, group="Sites", color="orange")