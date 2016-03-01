class LinuxHeaders < Formula
  desc "Header files of the Linux kernel"
  homepage "http://kernel.org/"
  url "https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.18.27.tar.xz"
  sha256 "ac9d2cd940e01cb2a659831fde4976e60d0241b0374026ed2ed7036d07039f06"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ee87dd44d9a8adc3984bd589598f8e7a3b256863b0f6e895ee90f8a46e54bd6" => :x86_64_linux
  end

  def install
    system "make", "headers_install", "INSTALL_HDR_PATH=#{prefix}"
    rm Dir[prefix/"**/{.install,..install.cmd}"]
  end

  test do
    system "ls", include
  end
end
