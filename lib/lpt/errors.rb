# frozen_string_literal: true

module Lpt
  class LptError < RuntimeError; end

  class ResourceCreationFailure < LptError; end
  class ResourceRetrievalFailure < LptError; end
end
