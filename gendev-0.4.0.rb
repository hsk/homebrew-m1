# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
require 'benchmark'

class Gendev040 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/gendev-0.4.0/archive/refs/tags/0.4.0o.tar.gz"
    sha256 "4eb42fb4a8002509c1e5ee4778b8f5f73a1c86b11e2e880001c6f7fa7cbb53c8"
    version "0.4.0"
  else
    system "false"
  end
  license "GPL-3.0-or-later" => { with: "GCC-exception-3.1" }

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "ca6ffc01cef72bde1976baed869c463348c869a680aed881817cea9a0ec2bc99"
  end

  depends_on "make"
  depends_on "wget"
  def sys p
    puts Benchmark.measure { system p }
  end
  def install

    print "#{prefix} #{lib}\n"

    #sys "GENDEV=#{prefix} make toolchain_build"
    sys "GENDEV=#{prefix} cd toolchain && make setup"
    sys "GENDEV=#{prefix} cd toolchain && make build-binutils"
    sys "GENDEV=#{prefix} cd toolchain && make build-gcc-1"
    sys "GENDEV=#{prefix} cd toolchain && make build-newlib"
    sys "GENDEV=#{prefix} cd toolchain && make build-gcc-2"
    sys "GENDEV=#{prefix} cd toolchain && make build-ldscripts"

    sys "GENDEV=#{prefix} make tools_build"
    sys "GENDEV=#{prefix} make sgdk_build"
    sys "GENDEV=#{prefix} make install"
  end

  def caveats
    <<~EOS
      Before you can use these tools you must export some variables to your $SHELL.
      export GENDEV=#{prefix}
    EOS
  end


  test do
    system "false"
  end
end
