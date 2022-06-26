#TODO build a more secure/reliable way to get IP
#If that server is down we can't get IP
#If they wanted they can manipulate response to make changes
# to our security groups. 
data "http" "my_ipv4" {
  url = "https://ipv4.icanhazip.com/"
}