require 'benchmark'

class GendevGcc < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/m1-gendev-gcc/archive/refs/tags/10.2.1.tar.gz"
    sha256 "7065e758947df675d6623e078f109fe7936c0a2aa65798868f239d9986402531"
  else
    system "false"
  end
  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "fa6b6c9c36d576916511ed0ea56a83f539ba5dac9c1486985106eb72cb8b1d8b"
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
