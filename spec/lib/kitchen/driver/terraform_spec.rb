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
require "support/kitchen/driver/terraform/create_examples"
require "support/kitchen/driver/terraform/destroy_examples"
require "support/kitchen/driver/terraform/verify_dependencies_examples"
require "support/terraform/configurable_context"
require "support/terraform/configurable_examples"

::RSpec.describe ::Kitchen::Driver::Terraform do
  include_context "instance"

  let :described_instance do
    driver
  end

  it_behaves_like ::Terraform::Configurable

  describe ".serial_actions" do
    subject do
      described_class.serial_actions
    end

    it "is empty" do
      is_expected.to be_empty
    end
  end

  describe "#create" do
    it_behaves_like "::Kitchen::Driver::Terraform::Create" do
      let :described_method do
        described_instance.method :create
      end
    end
  end

  describe "#destroy" do
    include_context "client"

    it_behaves_like "::Kitchen::Driver::Terraform::Destroy" do
      let :described_method do
        described_instance.method :destroy
      end
    end
  end

  describe "#verify_dependencies" do
    it_behaves_like "::Kitchen::Driver::Terraform::VerifyDependencies" do
      let :described_method do
        described_instance.method :verify_dependencies
      end
    end
  end
end
