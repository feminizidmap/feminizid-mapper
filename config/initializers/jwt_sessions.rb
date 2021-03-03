# frozen_string_literal: true

JWTSessions.encryption_key = ENV['SESSION_SECRET']

JWTSessions.token_store = :redis, { redis_url: ENV['REDIS_URL'] }
