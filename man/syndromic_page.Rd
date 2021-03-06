\docType{methods}
\name{syndromic_page}
\alias{syndromic_page}
\title{\code{syndromic_page}}
\arguments{
  \item{x}{a syndromic (\code{syndromicD} or
  \code{syndromicW}) object.}

  \item{tpoints.display}{This is used to choose how many
  days of alarms to display. The normal for daily data
  (syndromic object provided is form the class
  \code{syndromicD} ) is to show the entire last week (so 7
  or 5 days, depending on whether weekends are included).
  For weekly data the user my choose for instance 4 weeks
  (one month). The user can set this number to any desired
  number of days to tabulate.}

  \item{window}{the number of time points to plot, always
  finishing at the last time point recorded, or the date
  specified in the parameter "date" above.}

  \item{baseline}{whether to plot the baseline, by default
  equal to TRUE.}

  \item{UCL}{the dimension of the slot UCL, from the
  syndromic object, from which the user wants to plot the
  UCL. Set to NULL or to 0 if it is not desired to plot the
  UCL.}

  \item{algorithms}{an optional parameter specifying which
  dimensions of the alarm slot to plot and sum for a final
  alarm score. If not specified (NULL), all are plotted. If
  set to zero, none are plotted.}

  \item{limit}{the parameter specifying the limit above
  which alarms are considered meaningful. Only important if
  the user has specified that only syndromes with an alarm
  are to be plotted. Remember that this is not a
  statistical value, but the sum of the scores of each
  individual detection algorithm. If for instance the
  syndromic object has been subjected to detection using a
  \code{holt_winters_synd} algorithm with 3 alarm detection
  limits, and an \code{ewma_synd} algorithm with 3 alarm
  detection limits, than the maximum alarm score is 6. The
  limit parameter establishes the minimum value (in his 0-6
  scale) that in considered an alarm. By default 1 is used.
  It can be provided as a single value (if all syndromes
  are to have the same limit) or as a vector with length
  equal to the number of syndromes in use (number of
  columns in the slot observed)}

  \item{file.name}{an optional text to add to the date
  being evaluated, as the name of the file to be saved.}

  \item{title}{a tile for the html page. If not given the
  value in "file.name" is used.}

  \item{data.page}{the user should specify whether the
  plots should also provide a link to the original data, so
  that page viewers can inspect the original data. If using
  TRUE, the original data must be provided in the argument
  "data".}

  \item{data}{the original data to tabulate in case
  "data.page" has been set to TRUE.}

  \item{date.format}{the date format in the original data,
  if provided in the previous argument. For WEEKLY data,
  the original data may have been recorded daily or weekly
  (see \code{rawD_to_syndromicW} and
  \code{rawW_to_syndromicW}). If theoriginal date are
  recorded daily, please indicate the date.format. If the
  original data are recorded weekly, remember that the date
  format MUST be ISOweek, and for date.format please
  provide the value "ISOweek". See examples.}

  \item{syndromes.var}{the variable (column) in data to
  match to the syndromes found in the slot observed}

  \item{dates.var}{the variable (column) in data to look
  for dates, in order to find the data from last week.}

  \item{color.null}{a color for the table of alarms, used
  in cells giving the number of syndromic events which
  corresponded to NO alarm.}

  \item{color.low}{a color for the table of alarms, used in
  cells giving the number of syndromic events which
  generated an alarm score higher than 0, but lower than
  the limit for alarms.}

  \item{color.alarm}{a color for the table of alarms, used
  in cells giving the number of syndromic events which
  corresponded to an alarm.}

  \item{scale}{the maximum possible score (scale of
  alarms). Based on the number of detection algorithms
  used, and the number of detection limits set to each (3
  algorithms with 5 detection limits for each, for
  instance, will give a scale of 15)}

  \item{fill.colors}{the colors to be used for the 3
  degrees of alarm. By default they are yellow, orange and
  light red (tomato).}

  \item{arrow.colors}{the colors of the arrow for varying
  levels of alarm. By default green is used when the score
  is zero, and a progressive scale is used for increasing
  scores: orange, tomato and red.}
}
\description{
  A simple command to generate an html page that summarizes
  the current state of a syndromic (\code{syndromicD} or
  \code{syndromicW}) object. A "html" folder is created (or
  used if already existing) into the current working
  directory.
}
\examples{
data(lab.daily)
my.syndromicD <- raw_to_syndromicD (id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 dates.var=DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 remove.dow=c(6,0),
                                 add.to=c(2,1),
                                 data=lab.daily)
my.syndromicD <- holt_winters_synd(x=my.syndromicD,
                                evaluate.window=30,
                                frequency=5,
                                baseline.window=260)
syndromic_page (x=my.syndromicD,
                tpoints.display=5,
                file.name="SpeciesX",
                title="Lab data daily for Species X",
                data.page=TRUE,
                data=lab.daily,
                date.format="\%d/\%m/\%Y",
                dates.var="DateofSubmission",
                syndromes.var="Syndrome",
                scale=9)
data(lab.weekly)
my.syndromicW <- raw_to_syndromicW (id=lab.weekly$SubmissionID,
                                  syndromes.var=lab.weekly$Syndrome,
                                  week.var=lab.weekly$DateofSubmission)

my.syndromicW <- ewma_synd(x=my.syndromicW,
                          evaluate.window=10,
                          limit.sd=c(2.5,3,3.5),
                          pre.process="diff",
                          diff.window=4)
syndromic_page (x=my.syndromicW,
                tpoints.display=4,
                file.name="SpeciesX",
                title="Lab data daily for Species X",
                data.page=TRUE,
                data=lab.weekly,
                date.format="ISOweek",
                dates.var="DateofSubmission",
                syndromes.var="Syndrome",
                scale=9)
data(lab.daily)
my.syndromicW2 <- raw_to_syndromicW (id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 dates.var=DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 data=lab.daily)
my.syndromicW2 <- ewma_synd(x=my.syndromicW2,
                          evaluate.window=10,
                          limit.sd=c(2.5,3,3.5),
                          pre.process="diff",
                          diff.window=4)
syndromic_page(x=my.syndromicW2,
                tpoints.display=4,
                file.name="SpeciesX",
                title="Lab data daily for Species X",
                data.page=TRUE,
                data=lab.daily,
                date.format="\%d/\%m/\%Y",
                dates.var="DateofSubmission",
                syndromes.var="Syndrome",
                scale=9)
}
\keyword{methods}

