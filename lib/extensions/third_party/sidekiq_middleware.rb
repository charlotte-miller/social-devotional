class RequestStore::SidekiqMiddleware
  def call(worker, msg, queue)
    RequestStore.clear!
    yield
  end
end