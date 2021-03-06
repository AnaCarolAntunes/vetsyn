\docType{methods}
\name{syndromic_alarm}
\alias{syndromic_alarm}
\title{\code{syndromic_alarm}}
\arguments{
  \item{x}{a syndromic (\code{syndromicD} or
  \code{syndromicW}) object.}

  \item{pdf.report}{default is TRUE, that is, a pdf report
  will be generated.}

  \item{email.alarm.to}{email recipient(s) for when an
  alarm is detected. If a pdf report has been generated, it
  will be attached to the email. See examples for e-mail
  formats. Multiple e-mails should be separated by commas.
  If set to NULL, no e-mail will be generated.}

  \item{email.noalarm.to}{email recipient(s) for when NO
  alarm is detected. This is used so that a recipient can
  be warned that the calculations were performed and
  finished successfully, but no alarm was generated (for
  control that the system actuall ran with no problems).
  See examples for e-mail formats. Multiple e-mails should
  be separated by commas. If set to NULL, no e-mail will be
  generated.}

  \item{date}{by default (NULL) it looks up alarms in the
  last date saved in the syndromic object, but the user can
  set past dates in order to plot historical alarms. Dates
  must be provided in the same format as they are stored in
  dates, that is, for \code{syndromicD} objects, in the
  format "yyyy-mm-dd" (for instance "2013-12-31"); and for
  \code{syndromicW} in the ISOweek format (for instance
  "2014-W01-2")}

  \item{plot.all}{by default, only syndromes associated
  with an alarm are plotted (plot.all=FALSE), but the user
  can set plot.all=TRUE to plot all syndromes found in the
  syndromic object.}

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
  dimensions of the alarms slot to plot and sum for a final
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
  limit parameter establishes the minimum value (in this
  0-6 scale) that in considered an alarm. By default 1 is
  used. It can be provided as a single value (if all
  syndromes are to have the same limit) or as a vector with
  length equal to the number of syndromes in use (number of
  columns in the slot observed)}

  \item{file.name}{an optional text to add to the date
  being evaluated, as the name of the file to be saved.}

  \item{email.from}{e-mail client to use when sending
  alarms, if left as NULL, the default email in the package
  mail will be used, but it doesn't support attachments
  (email will be sent without a pdf report attachment)}

  \item{smtpServer}{to be used as control prameter in the
  mail sending function. The smtpServer for the email
  client provided as the "email.from" above. If left as
  NULL, the default email in the package mail will be used,
  but it doesn't support attachments (email will be sent
  without a pdf report attachment).}

  \item{subject}{the subject in the email in case of
  alarms. By default it's the system date, plus the text
  "ALARM: There are alarms today"}

  \item{message}{any message that the user wants to add to
  the body of the email generated in case of alarm. This
  will be added to the default message, which is the name
  of the syndromes which generated an alarm.}

  \item{height}{in inches, for the pdf page. The default
  (7.5) fits well a letter or A4 page.}

  \item{height}{in inches, for the pdf page. The default
  (10.5) fits well a letter or A4 page.}

  \item{pdf.dir}{whether to create (or use) a directory
  called "PDF_reports" within the current working
  directory, to save the files. If set to FALSE, the
  current working directory is used. The current working
  directory is not changed by using the function.}
}
\description{
  A simple command to generate an alarm around a syndromic
  (\code{syndromicD} or \code{syndromicW}) object - the
  user can generate automated e-mails and also generate a
  pdf report of all syndromes in a syndromic object, or
  only those for which an alarm was generated.
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

 ##substitute 'at' for the appropriate synbol in the example below
syndromic_alarm(x=my.syndromicD,
               plot.all=TRUE,
               email.alarm.to="<dorea.meyer'at'gmail.com>",
               email.noalarm.to="<dorea.meyer'at'gmail.com>")
data(lab.daily)
my.syndromicW <- raw_to_syndromicW (id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 dates.var=DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 data=lab.daily)
my.syndromicW <- ewma_synd(x=my.syndromicW,
                          evaluate.window=10,
                          limit.sd=c(2.5,3,3.5),
                          pre.process="diff",
                          diff.window=4)

 ##substitute 'at' for the appropriate syMbol in the example below
syndromic_alarm(x=my.syndromicW,
               plot.all=TRUE,
               email.alarm.to="<dorea.meyer'at'gmail.com>",
               email.noalarm.to="<dorea.meyer'at'gmail.com>")
}
\keyword{methods}

