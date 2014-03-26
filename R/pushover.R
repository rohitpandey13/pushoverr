#' Send a message using Pushover
#'
#' \code{pushover} sends a message (push notification) to a user or group.
#' Messages can be given different priorities, play different sounds, or require
#' acknowledgments. A unique request token is returned.
#'
#' The \code{pushover_normal}, \code{pushover_quiet}, \code{pushover_high}, and
#' \code{pushover_emergency} functions send messages with those priorities.
#'
#' @export
#' @aliases pushover pushover_normal pushover_quiet pushover_high pushover_emergency
#' @param message The message to be sent (max. 512 characters)
#' @param token The application token
#' @param user The user or group key to send the message to
#' @param device The device to send the notification to (optional)
#' @param title The title of the message (optional)
#' @param url A URL to be included in the message (optional, max. 512 characters)
#' @param url_title A title for the given url (optional, max. 100 characters)
#' @param priority The message's priority. One of: -1 (quiet), 0 (normal, default), 1 (high), 2 (emergency). Quiet messages do not play a sound. Emergency messages require acknowledgement.
#' @param timestamp The time to associate with the message (default: now, format: UNIX time)
#' @param sound The sound to be played when the message is received (see \code{\link{get_sounds}}) (default: 'pushover')
#' @param callback A callback URL. For emergency priority, a POST request will be sent to this URL when the message is acknowledged (see \link{https://pushover.net/api#receipt}) (optional)
#' @param retry The number of seconds between re-sending of an unacknowledged emergency message (default: 60, min: 30)
#' @param expire The number of seconds until an unacknowledged emergency message will stop being resent (default: 3600, max: 86400).
#' @return A string containing a Pushover request token
#' @note The available sounds are listed in the `pushover_sounds` variable
#' @examples
#' # Send a pushover message
#' pushover(message='Hello World!', token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'          user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' 
#' # Send a message with high priority and a title
#' pushover_high(message='The sky is falling', title='Alert',
#'               token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'               user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#'
#' # Send an emergency message. Emergency messages will be re-sent until they
#' # are acknowledged (in this case, every 60 seconds)
#' pushover_emergency(message='PAY YOUR TAXES!',
#'                   token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                   user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG',
#'                   retry=60)
#'                              
#' # Send a quiet message
#' pushover_quiet(message='Pssst. Walk the dog when you wake up',
#'               token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'               user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')

pushover <- function(message, token, user, device=NA_character_,
                     title=NA_character_, url=NA_character_,
                     url_title=NA_character_, priority=0, timestamp=NA_integer_,
                     sound='pushover', callback=NA_character_, retry=60,
                     expire=3600)
{    
    msg <- PushoverMessage(message=message, token=token, user=user, device=device,
                           title=title, url=url, url_title=url_title,
                           priority=priority, timestamp=timestamp,
                           sound=sound, callback=callback, retry=retry,
                           expire=expire)    
    
    response <- send(msg)
    
    if(is.success(response))
    {
        return(request(response))
    }
    else
    {
        stop(response@content$errors)
    }
}

#' @export
pushover_quiet <- function(message, token, user, device=NA_character_,
                           title=NA_character_, url=NA_character_,
                           url_title=NA_character_, timestamp=NA_integer_)
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=-1,
                    timestamp=timestamp, sound='none'))
}

#' @export
pushover_normal <- function(message, token, user, device=NA_character_,
                            title=NA_character_, url=NA_character_, 
                            url_title=NA_character_, timestamp=NA_integer_,
                            sound='pushover')
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=0,
                    timestamp=timestamp, sound=sound))
}

#' @export
pushover_high <- function(message, token, user, device=NA_character_,
                          title=NA_character_, url=NA_character_,
                          url_title=NA_character_, timestamp=NA_integer_,
                          sound='pushover')
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=1,
                    timestamp=timestamp, sound=sound))
}

#' @export
pushover_emergency <- function(message, token, user, device=NA_character_,
                               title=NA_character_, url=NA_character_, 
                               url_title=NA_character_, timestamp=NA_integer_,
                               sound='pushover', callback=NA_character_,
                               retry=60, expire=3600)
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=2,
                    timestamp=timestamp, callback=callback, sound=sound,
                    retry=retry, exipre=expire))
}