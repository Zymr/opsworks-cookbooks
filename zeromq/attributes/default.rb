#
# Cookbook Name:: zeromq
# Attributes:: default
#
# Copyright (C) 2013 Johannes Plunien
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['zeromq']['dir'] = '/usr/local'
default['zeromq']['install_method'] = 'source'
default['zeromq']['sha256_sum'] = '43d61e5706b43946aad4a661400627bcde9c63cc25816d4749c67b64c3dab8db'
default['zeromq']['src_url'] = 'http://download.zeromq.org'
default['zeromq']['version'] = '4.1.1'
default['zeromq']['creates'] = 'libzmq.so'
