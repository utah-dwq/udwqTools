% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/buildLDC.R
\name{buildLDC}
\alias{buildLDC}
\title{Calculate parameter loading capacity}
\usage{
buildLDC(
  x,
  flow,
  date,
  value,
  location,
  parameter,
  crit,
  loading_units,
  mos = 0.1,
  cf,
  plot_it = TRUE
)
}
\arguments{
\item{x}{A data frame containing columns indicating flow and parameter concentration for given dates (required for plotting: location and parameter name). Note that flow data for which no parameter values exist are still used to construct LDC plot.}

\item{flow}{String. Column name containing flow data.}

\item{date}{String. Column name containing date data.}

\item{value}{String. Column name containing parameter concentration data.}

\item{location}{String Column name containing location name(s).}

\item{parameter}{String. Column name containing parameter name.}

\item{crit}{Numeric.  Represents the standard criterion (in same concentration units as parameter) against which observed loadings are compared.}

\item{loading_units}{String. Indicates the loading units (amount/time) to be plotted on the y-axis of the LDC (if plot_it = TRUE).}

\item{mos}{Numeric. A decimal representing the percent margin of safety to apply to the loading capacity for management decisions.}

\item{cf}{Numeric. A value representing the correction factor linking flow and parameter concentration to desired unit (load per time).}

\item{plot_it}{Logical. If TRUE, plots observed capacity and loading capacity in one figure in a load duration curve framework.}
}
\value{
A data frame containing original columns supplied to function plus observed loading, loading capacity, loading capacity plus margin of safety, season, and flow percentile.
}
\description{
Uses flow, parameter concentration, and standard values to determine observed loading and loading capacity
}
