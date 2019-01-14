#' Read facility information from EPA ECHO webservices
#'
#' This function extracts facility information from EPA ECHO based on argument inputs.
#' @param ... additional arguments to be passed to ECHO query path. See https://echo.epa.gov/tools/web-services/facility-search-water#!/Facility_Information/get_cwa_rest_services_get_facility_info for optional arguments for facilities. Note that arguments for output are ignored.
#' @return A data frame of EPA ECHO facility information
#' @importFrom jsonlite fromJSON
#' @examples
#' #Extract facility locations in Utah
#' ut_fac=readECHO_fac(p_st="ut", p_act="y")
#' head(ut_fac)


#' @export
readECHO<-function(type="", ...){
args=list(...)

p_st="ut"
p_act="y"
p_impw="y"
args=list(p_st=p_st,p_act=p_act,p_impw=p_impw)

path="https://ofmpub.epa.gov/echo/cwa_rest_services.get_facility_info"
args$output="JSON"

path=paste0(path, "?")
for(n in 1:length(args)){
	for(i in 1:length(unlist(args[n]))){
		arg_ni=paste0(names(args[n]),"=",unlist(args[n])[i],"&")
		path=paste0(path,arg_ni)
	}
}
path=gsub('.{1}$', '', path)

print("Querying facility information...")
fac_query=jsonlite::fromJSON(path)
geoJSON_path=paste0("https://ofmpub.epa.gov/echo/cwa_rest_services.get_geojson?output=GEOJSON&qid=",fac_query$Results$QueryID)
print("Querying facility geometries...")
fac_geoJSON=jsonlite::fromJSON(geoJSON_path)
result=fac_geoJSON$features

return(result)

}
