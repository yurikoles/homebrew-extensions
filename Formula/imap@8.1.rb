# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1607663620"
  version "8.1.0"
  sha256 "526879a717eac856902285b3d01730719ab832540fd1ef6a28344d81698474ce"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 7
    sha256 "f9dc60a0aa958c5b16095cdef9390700301bcd088c82331ad22640196b09e44e" => :catalina
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/imap.so"
    (include/"php/ext"/extension).install Dir["php_*.h"]
    write_config_file
  end
end
