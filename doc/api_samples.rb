# Copyright 2012 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

###############################################################################
# Inspecting the APIs discovery document
#
# https://www.googleapis.com/discovery/v1/apis

###############################################################################
# Loading a Google+ profile
#
# Put binding.pry in a controller, load the page, and then run the following
# in the shell.  Notice, this is a newer Google API which google-api-ruby-
# client can load via a discovery document.
#
# See also: https://developers.google.com/+/api/latest
plus = google_client.discovered_api("plus")
plus.to_h.keys
response = google_client.execute(plus.people.get, :userId => 'me')
response.status
response.body
profile = JSON.parse(response.body)

# {"kind"=>"plus#person",
#  "etag"=>"\"yAQ47ZxCtzso1frCwoRlxM02Y-A/IgE2d8pvjfuRGMB2ofII5nz8s04\"",
#  "id"=>"115478738847874567952",
#  "displayName"=>"Shannon Behrens",
#  "name"=>{"familyName"=>"Behrens", "givenName"=>"Shannon"},
#  "tagline"=>
#   "In this life we cannot do great things. We can only do small things with great love. -- Mother Teresa",
#  "gender"=>"male",
#  "aboutMe"=>
#   "Catholic, father of six, open source enthusiast, Python and Ruby programmer.<br><br>Here&#39;s my blog: <a href=\"http://jjinux.blogspot.com/\">JJinuxLand</a>",
#  "url"=>"https://plus.google.com/115478738847874567952",
#  "image"=>
#   {"url"=>
#     "https://lh3.googleusercontent.com/-abePnTvm7gA/AAAAAAAAAAI/AAAAAAAAAAA/lrGQeFxJ8os/photo.jpg?sz=50"},
#  "emails"=>[{"value"=>"jjinux@gmail.com", "primary"=>true}],
#  "urls"=>
#   [{"value"=>"http://jjinux.blogspot.com"},
#    {"value"=>"http://github.com/jjinux"},
#    {"value"=>"https://plus.google.com/115478738847874567952",
#     "type"=>"profile"},
#    {"value"=>"https://www.googleapis.com/plus/v1/people/115478738847874567952",
#     "type"=>"json"}],
#  "organizations"=>
#   [{"name"=>"St. Mary's College of California",
#     "title"=>"Math and Computer Science",
#     "type"=>"school"},
#    {"name"=>"YouTube", "title"=>"Developer Advocate", "type"=>"work"}]}

###############################################################################
# Fetching the user's playlists
#
# Put binding.pry in a controller, load the page, and then run the following
# in the shell.  Notice, this is an older Google API.  It's not supported by
# google-api-ruby-client.  However, you can still use Signet (i.e.
# signet_client) in order to make requests authenticated with OAuth2.
#
# See also: http://code.google.com/apis/youtube/2.0/reference.html
response = signet_client.fetch_protected_resource(
  :uri => 'https://gdata.youtube.com/feeds/api/users/default/playlists?v=2&alt=jsonc')

# {"apiVersion"=>"2.1",
#  "data"=>
#   {"totalItems"=>3,
#    "startIndex"=>1,
#    "itemsPerPage"=>25,
#    "items"=>
#     [{"id"=>"BC43D9C99918B845",
#       "created"=>"2011-07-19T18:08:24.000Z",
#       "updated"=>"2011-07-24T23:58:21.000Z",
#       "author"=>"jjinux",
#       "title"=>"New Playlist",
#       "description"=>"New Description",
#       "size"=>4,
#       "thumbnail"=>
#        {"sqDefault"=>"http://i.ytimg.com/vi/4PkcfQtibmU/default.jpg",
#         "hqDefault"=>"http://i.ytimg.com/vi/4PkcfQtibmU/hqdefault.jpg"}},
#      {"id"=>"261787A03AF35201",
#       "created"=>"2011-07-19T14:19:37.000Z",
#       "updated"=>"2011-07-19T17:37:19.000Z",
#       "author"=>"jjinux",
#       "title"=>"Another Name",
#       "description"=>"Another Description",
#       "size"=>7,
#       "thumbnail"=>
#        {"sqDefault"=>"http://i.ytimg.com/vi/ehaA7_97KE0/default.jpg",
#         "hqDefault"=>"http://i.ytimg.com/vi/ehaA7_97KE0/hqdefault.jpg"}},
#      {"id"=>"0281BC97AD5E844D",
#       "created"=>"2011-07-19T13:41:41.000Z",
#       "updated"=>"2011-07-19T14:17:38.000Z",
#       "author"=>"jjinux",
#       "title"=>"Name",
#       "description"=>"Description",
#       "size"=>1,
#       "thumbnail"=>
#        {"sqDefault"=>"http://i.ytimg.com/vi/drjGn_JpTOk/default.jpg",
#         "hqDefault"=>"http://i.ytimg.com/vi/drjGn_JpTOk/hqdefault.jpg"}}]}}
