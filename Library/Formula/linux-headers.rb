class LinuxHeaders < Formula
  desc "Header files of the Linux kernel"
  homepage "http://kernel.org/"
  url "https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.18.27.tar.xz"
  sha256 "ac9d2cd940e01cb2a659831fde4976e60d0241b0374026ed2ed7036d07039f06"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "f8aa29cafbdfd0a815970dfcffe5e56cc9a8033b34caee5ea5483e729cff9700" => :x86_64_linux
  end

  def install
    system "make", "headers_install", "INSTALL_HDR_PATH=#{prefix}"
    rm Dir[prefix/"**/{.install,..install.cmd}"]
  end

  test do
    system "ls", include
  end
end
