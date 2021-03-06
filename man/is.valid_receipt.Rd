% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is.valid_receipt.R
\name{is.valid_receipt}
\alias{is.valid_receipt}
\title{Determine whether or not a given message receipt is valid}
\usage{
is.valid_receipt(receipt)
}
\arguments{
\item{receipt}{A message receipt (e.g., "KAWXTswy4cekx6vZbHBKbCKk1c1fdf")}
}
\value{
A boolean value for each given message receipt ID indicating whether
that receipt ID is valid (\code{TRUE}) or not (\code{FALSE})
}
\description{
Receipts are 30-character strings containing letters and
numbers ([A-Za-z0-9])
}
\details{
\code{is.valid_receipt} determines whether or not a given message receipt
is valid or not according to Pushover's specifications. It does not determine
whether or not the given receipt actually exists.
}
\examples{
\dontrun{
is.valid_receipt(receipt = "KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
}

}

