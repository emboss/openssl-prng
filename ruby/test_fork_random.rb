require 'openssl'

OpenSSL::Random.random_bytes(4)
pid = fork do
  p [ $$, OpenSSL::Random.random_bytes(4) ]
end
Process.waitpid2(pid)

loop do
  xpid = fork do
    p [ $$, OpenSSL::Random.random_bytes(4) ] if $$ == pid
  end
  Process.waitpid2(xpid)
  break if xpid == pid
end
