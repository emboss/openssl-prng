require 'openssl'

module OpenSSL::Random
  class << self

    old_rand = instance_method(:random_bytes)

    define_method :random_bytes do |n=nil|
      n = n ? n.to_int : 16

      @pid = 0 unless defined?(@pid)
      pid = $$
      unless @pid == pid # detect a fork and modify PRNG state
        add_predictable(pid)
        add_urandom
        @pid = pid
      end
      old_rand.bind(self).call(n)
    end

    private

    ##
    # Adds predictable values to the state. Enough to
    # make the forking issue go away, but the truly
    # paranoid want to add more than this and
    # use 'add_urandom' on top of this.
    #
    def add_predictable(pid)
      now = Time.now
      ary = [now.to_i, now.nsec, @pid, pid]
      OpenSSL::Random.random_add(ary.join('').to_s, 0.0)
    end

    ##
    # OpenSSL notices that /dev/urandom is a device
    # and will add 2048 bytes (instead of reading
    # infinitely) of random data to its internal state,
    # which is actually more than the size of the
    # internal state.
    #
    def add_urandom
      begin
        OpenSSL::Random.load_random_file('/dev/urandom')
      rescue Errno::ENOENT
        # not available, reraise if mandatory for you
      end
    end

  end
end
