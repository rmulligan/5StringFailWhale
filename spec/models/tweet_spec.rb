require 'spec_helper'

describe Tweet do
  it { should have_fields(:loc, :tags).of_type(Array) }
  it { should be_timestamped_document }
  it { should have_index_for({ loc: '2d', tags: 1}).with_options(background: true) }
end
