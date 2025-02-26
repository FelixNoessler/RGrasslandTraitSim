#' Title
#'
#' @returns
#' @export
#'
#' @examples
GrasslandTraitSim_init <- function() {
  JuliaCall::julia_setup(installJulia = TRUE)
  JuliaCall::julia_install_package_if_needed("GrasslandTraitSim")
  JuliaCall::julia_install_package_if_needed("Unitful")
  JuliaCall::julia_library("GrasslandTraitSim")
  JuliaCall::julia_library("Unitful")
  JuliaCall::julia_source(here::here("R/wrapper.jl"))
}


#' Title
#'
#' @param named_vec
#'
#' @returns
#' @export
#'
#' @examples
GrasslandTraitSim_parameter <- function(named_vec) {
  p <- NULL
  if (missing(named_vec)) {
    p <- JuliaCall::julia_call("GrasslandTraitSim.optim_parameter")
  } else {
    p <- JuliaCall::julia_call("parameter_wrapper", names(named_vec), unname(named_vec))
  }

  return(p)
}


#' Title
#'
#' @param plotID
#' @param p
#'
#' @returns
#' @export
#'
#' @examples
GrasslandTraitSim_solve <- function(plotID, p) {
  JuliaCall::julia_call("solve_wrapper", plotID, p)
}


#' Title
#'
#' @param d
#'
#' @returns
#' @export
#'
#' @examples
GrasslandTraitSim_getdata <- function(d) {
  JuliaCall::julia_call("dim_array_to_array", d)
}

