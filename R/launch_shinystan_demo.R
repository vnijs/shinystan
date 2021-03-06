# This file is part of shinyStan
# Copyright (C) 2015 Jonah Sol Gabry & Stan Development Team
#
# shinyStan is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
# 
# shinyStan is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <http://www.gnu.org/licenses/>.



#' Launch shinyStan app in demo mode
#'
#' The user will be presented with the option of launching the default
#' shinyStan demo (in which case the app will launch immediately)
#' or running a Stan demo model (\pkg{rstan}), after which shinyStan
#' will launch.
#'
#' @param ... Optional arguments to pass to \code{stan_demo} (\pkg{rstan}).
#'
#' @return In addition to launching the \strong{shinyStan} app an S4 object of 
#' class \code{shinystan} is returned. 
#'
#' @details Unless you are using RStudio, \code{launch_shinystan} will open your
#' system's default web browser. For RStudio users \strong{shinyStan} will
#' launch in RStudio's (pop-up) Viewer pane. If you prefer to use \strong{shinyStan}
#' in your web browser (or if you are having trouble with the RStudio Viewer pane) you 
#' can click on 'Open in Browser' at the top of the Viewer pane.
#' @seealso \code{\link[shinyStan]{launch_shinystan}}, \code{\link[shinyStan]{as.shinystan}}, 
#' @export
#' @examples
#' \dontrun{
#' launch_shinystan_demo()
#' }
#'

launch_shinystan_demo <- function(...) {
  choices <- c("Default shinyStan demo (launches immediately)",
               "Select a Stan demo (first runs RStan, then launches)")
  choice <- select.list(choices)
  if (choice == choices[1]) {
    demo_name <- "eight_schools"
    out_name <- paste0("shinystan_demo_object")
    on.exit(cleanup_shinystan(get("shinystan_object"), out_name, is_stanfit_object = FALSE))
    launch_demo(get(demo_name))
  } else {
    rstan_check()
    rstan_demo <- rstan::stan_demo(...)
    launch_shinystan(rstan_demo)
  }
}
