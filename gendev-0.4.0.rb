# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gendev040 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/gendev-0.4.0/archive/refs/tags/0.4.0f.tar.gz"
    sha256 "6ab8b37ca26fdee1de6f222c3f55b61862237eb8aaf0faac97840d21e6853411"
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
 
  def install

    system "echo #{prefix} #{lib}"
    system "GENDEV=#{prefix} make -j1"
    system "GENDEV=#{prefix} make -j1 install"
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
