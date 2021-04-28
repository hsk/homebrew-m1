require 'benchmark'

class M1Gendev061 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/m1-gendev/archive/refs/tags/0.6.1.tar.gz"
    sha256 "42d02b183f941a4e4c6aa7e7dcd1dbcbd9fb2578314ccdf65c722a502afa6f99"
  else
    system "false"
  end

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "d2c556f4c47542c856941f48aac94c106b965868bfcc37aded59bfcf08434342"
  end

  depends_on "make"
  depends_on "gendev-gcc"
  depends_on "wget"
  def sys p
    puts Benchmark.measure { system p }
  end
  def install
    mkdir "./build"
    pre = Formula["gendev-gcc"].prefix
    sys "cp -rf #{pre}/* ./build/.\n"
    sys "GENDEV=#{prefix} make -j1 tools_build"
    sys "GENDEV=#{prefix} make -j1 sgdk_build"
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
