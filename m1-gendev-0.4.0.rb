require 'benchmark'

class M1Gendev040 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/m1-gendev/archive/refs/tags/0.4.0.tar.gz"
    sha256 "31c7f97c864b2b622bb943699f8c344f3cda55ac7bff84edb64f70f59dd3a887"
  else
    system "false"
  end

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "873071668581a4a0c728efeef3cb1c1500e41724d26199e655688d6048fbdd99"
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
