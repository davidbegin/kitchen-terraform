# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
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

require "kitchen/driver/terraform"
require "kitchen/terraform/create_directories"

::Kitchen::Driver::Terraform::Create = lambda do |_state|
  catch :failure do
    catch :success do
      ::Kitchen::Terraform::CreateDirectories
        .call directories: [
          self[:directory],
          ::File.dirname(self[:plan]),
          ::File.dirname(self[:state])
        ]
    end.tap do |created_directories|
      logger.debug created_directories
    end
    return
  end.tap do |failure|
    raise ::Kitchen::ActionFailed,
          failure
  end
end