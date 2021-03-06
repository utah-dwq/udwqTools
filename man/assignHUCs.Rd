% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assignHUCs.r
\name{assignHUCs}
\alias{assignHUCs}
\title{Assign HUC 8 & 12 values to sites}
\usage{
assignHUCs(data, lat = "LatitudeMeasure", long = "LongitudeMeasure")
}
\arguments{
\item{data}{Input dataset. Must include latitude & longitude columns.}

\item{lat}{Name of latitude column. Default matches WQP objects.}

\item{long}{Name of longitude column. Default matches WQP objects.}
}
\value{
Returns the input data frame with HUC 8 & 12 information appended.
}
\description{
This function assigns HUC 8 & 12 values to water quality portal type site objects (or data with site information attached).
}
\examples{
# Read a couple of sites from Mantua Reservoir
sites=readWQP(type="sites", siteid=c("UTAHDWQ_WQX-4900440","UTAHDWQ_WQX-4900470"))
sites_HUCs=assignHUCs(sites)
}
