# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT72 < AbstractPhp72Extension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.10.2.tgz"
  sha256 "0ebc61052eb12406dddf5eabfe8749a12d52c566816b8aab04fb9916d0c26ed2"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "95a0c39beed8dcb4ae8a3b31f040f12b8032bdf4d5fabdfcc5c0f183faa79e49" => :catalina
  end

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-amqp=shared", \
           "--with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}"
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file
  end
end
