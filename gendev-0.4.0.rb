require 'benchmark'

class Gendev040 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/gendev-0.4.0/archive/refs/tags/0.4.0p.tar.gz"
  else
    system "false"
  end

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
