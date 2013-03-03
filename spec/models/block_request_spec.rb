require 'spec_helper'

describe BlockRequest do
  
  it { should belong_to :author }
  it { should belong_to :approver }
  it { should belong_to :source }
  
end
