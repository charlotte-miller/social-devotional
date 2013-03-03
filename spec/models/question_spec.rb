require 'spec_helper'

describe Question do
  it { should have_many :answers  } 
  it { should belong_to( :meetings ) }
  it { should belong_to( :lessons  ) }
  
  
end
