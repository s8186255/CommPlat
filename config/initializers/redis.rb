require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(:host => '112.124.57.143', :port => 6379, password: 'lendlove') }
