\docType{methods}
\name{update_syndromic}
\alias{update_syndromic}
\title{\code{update_syndromicD}}
\arguments{
  \item{x}{the \code{syndromicD} object to be updated (if
  one does not already exist, please use
  "raw_to_syndromicD" or "syndromicD")}

  \item{id}{indicates a variable (or multiple variables)
  which should be used to identify unique events in the
  data. It can be provided as an R vector (p.e.
  mydata$myid), as the name of a Data Frame column (p.e.
  id=myid, data=my.data), or as multiple column names (p.e.
  id=list(id1,id2,id3), data=my.data).}

  \item{syndromes.var}{the variable that identifies group
  membership (in general the syndromic grouping). Can be
  \code{numeric}, \code{character} or \code{factor}.}

  \item{add.syndromes}{a logical argument indicating
  whether syndromic groups found in the new data and not
  existing in the old syndromic object should be added (set
  to TRUE) or ignored (set to FALSE).}

  \item{dates.var}{The vector (dates.var=mydata$mydates) or
  column name (dates.var=mydates, data=mydata) where the
  dates of the events are to be found.}

  \item{date.format}{The date.format of the date.variable.
  Default is "%d/%m/%Y". See strptime() for format
  specifications}

  \item{remove.dow}{An optional argument, by default set to
  FALSE. This allows the user to specify weekdays that must
  be removed from the dataset, for instance when weekends
  are not relevant. This must be se to integers between 0
  and 6 specifying the day of the week to be removed. To
  remove saturdays and sundays, for instance, set
  remove.dow=c(6,0)}

  \item{add.to}{when remove.dow is used, the user has the
  option to completely remove any counts assigned to the
  days of week to be remove (set add.to=0) or add them to
  the following or precedent day. For instance when
  removing weekends, the counts registered during weekends
  can be assigned to the following Monday or the preceding
  Friday, using add.to=1 or add.to=-1 respectively. Please
  note that: (i) the vector add.to must have the exact same
  dimensions as remove.dow. To remove weekends adding any
  observed counts to the following Monday the user would
  need to set remove.dow=c(6,0) and add.to=c(2,1)
  (Saturdays added to 2 days ahead, and Sunday to 1 day
  ahead)}

  \item{replace.dates}{a logical argument indicating
  whether dates in the new dataset for which data were
  already available in the syndromic object should replace
  the old values (set to TRUE) or be ignored (set to
  FALSE)}

  \item{data}{Optional argument. If used the other
  arguments can be specified as column names within the
  dataset provided through this argument}

  \item{x}{the syndromicW object to be updated (if one does
  not already exist, please use "rawD_to_syndromicW" or
  "syndromicW")}

  \item{id}{indicates a variable (or multiple variables)
  which should be used to identify unique events in the
  data. It can be provided as an R vector (p.e.
  mydata$myid), as the name of a Data Frame column (p.e.
  id=myid, data=my.data), or as multiple column names (p.e.
  id=list(id1,id2,id3), data=my.data).}

  \item{syndromes.var}{the variable that identifies group
  membership (in general the syndromic grouping). Can be
  \code{numeric}, \code{character} or \code{factor}.}

  \item{add.syndromes}{a logical argument indicating
  whether syndromic groups found in the new data and not
  existing in the old syndromic object should be added (set
  to TRUE) or ignored (set to FALSE).}

  \item{dates.var}{The vector (dates.var=mydata$mydates) or
  column name (dates.var=mydates, data=mydata) where the
  dates of the events are to be found.}

  \item{date.format}{The date.format of the date.variable.
  Default is "%d/%m/%Y". See strptime() for format
  specifications. If the data have already been recorded
  weekly, then the column "dates.var" MUST be in the
  ISOweek format, and the date.format must be set to
  "ISOweek".}

  \item{replace.dates}{a logical argument indicating
  whether dates in the new dataset for which data were
  already available in the syndromic object should replace
  the old values (set to TRUE) or be ignored (set to
  FALSE)}

  \item{data}{Optional argument. If used the other
  arguments can be specified as column names within the
  dataset provided through this argument}
}
\value{
  an updated object of the class \code{syndromicD} with the
  following slots: (1) OBSERVED: The previous observed
  matrix is updated adding lines corresponding to the new
  events found in the new dataset; (2) DATES: also updated
  to include extra dates; (3) BASELINE: if a baseline
  matrix was available lines are added, with data copied
  from the slot observed; (4) ALARMS: the same number of
  lines added to observed are added, but given a value of
  NA to make clear that aberration detection analyses were
  not yet carried out in these data; (5) UCL and (6) LCL:
  same as alarms.

  an updated object of the class \code{syndromicW} with the
  following slots: (1) OBSERVED: The previous observed
  matrix is updated adding lines corresponding to the new
  events found in the new dataset; (2) DATES: also updated
  to include extra dates; (3) BASELINE: if a baseline
  matrix was available lines are added, with data copied
  from the slot observed; (4) ALARMS: the same number of
  lines added to observed are added, but given a value of
  NA to make clear that aberration detection analyses were
  not yet carried out in these data; (5) UCL and (6) LCL:
  same as alarms.
}
\description{
  Updates an object of the class \code{syndromicD}, adding
  additional rows (additional time points) from raw,
  observed data. To understand a syndromic object, please
  refer to the help page for the syndromic class.

  Updates an object of the class \code{syndromicW}, adding
  additional rows (additional time points) from raw,
  observed data. Observed data may have been recorded
  weekly, but the function can also accomodate for data
  that were originally collected daily, or for which the
  day of the event was recorded, and the user wants to
  group those data weekly . To understand a syndromicW
  object, please refer to the help page for the syndromic
  class.
}
\examples{
data(lab.daily)
data(lab.daily.update)
my.syndromicD <- raw_to_syndromicD (id=SubmissionID,
                                  syndromes.var=Syndrome,
                                  dates.var=DateofSubmission,
                                  date.format="\%d/\%m/\%Y",
                                remove.dow=c(6,0),
                                add.to=c(2,1),
                                  data=lab.daily)
 my.syndromicD <- update_syndromicD(x=my.syndromicD,
                                id=SubmissionID,
                                syndromes.var=Syndrome,
                                add.syndromes=TRUE,
                                dates.var=DateofSubmission,
                                date.format="\%d/\%m/\%Y",
                                remove.dow=c(6,0),
                                add.to=c(2,1),
                                replace.dates=FALSE,
                                data=lab.daily.update)
data(lab.daily)
data(lab.daily.update)
my.syndromicW <- raw_to_syndromicW (id=SubmissionID,
                                  syndromes.var=Syndrome,
                                  dates.var=DateofSubmission,
                                  date.format="\%d/\%m/\%Y",
                                  data=lab.daily)
my.syndromicW <- update_syndromic(x=my.syndromicW,
                                 id=lab.daily.update$SubmissionID,
                                 syndromes.var=lab.daily.update$Syndrome,
                                 add.syndromes=TRUE,
                                 dates.var=lab.daily.update$DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 replace.dates=TRUE)


my.syndromicW <- update_syndromic(x=my.syndromicW,
                                 id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 add.syndromes=TRUE,
                                 dates.var=DateofSubmission,
                                 date.format="ISOweek",
                                 replace.dates=TRUE,
                                 data=lab.weekly.update)##'
}

