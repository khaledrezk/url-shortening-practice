from django.db.utils import IntegrityError
import json
import requests

from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseNotFound, HttpResponseRedirect, HttpResponseServerError, JsonResponse
from django.shortcuts import render
from .models import Link, gen_short_url
# Create your views here.

RETRIES = 5 # rehash to get a new short in case of collision.
#Update when having a domain name. 
HOSTNAME = requests.get("https://ipv4.icanhazip.com/").text.strip() + ":8000"
def redirect(request, short_url):
    res = Link.objects.filter(short_url=short_url)
    if len(res) == 0:
        return JsonResponse({"msg": "URL wasn't added."})
    long_url = res[0].long_url
    return HttpResponseRedirect(long_url)

def add_long_url(request):
    body = json.loads(request.body)
    if "long_url" not in body.keys():
        return HttpResponseBadRequest("Long url should be added to body.")
    long_url = body["long_url"]
    short_url = ""
    
    for i in range(RETRIES):
        try:
            short_url = gen_short_url(long_url)
            link = Link(short_url=short_url, long_url=long_url)
            link.save()
            full_short_url = HOSTNAME + "/" + short_url
            return JsonResponse({"long_url":long_url, "short_url":full_short_url})
        except IntegrityError as e:
            pass
    return HttpResponseServerError("Sorry we are facing issues now.")
