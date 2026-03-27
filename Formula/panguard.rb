class Panguard < Formula
  desc "Security platform for AI agents - scan, audit, and protect AI skills"
  homepage "https://panguard.ai"
  version "1.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-darwin-arm64.tar.gz"
      sha256 "512e794e58f22fa50148cd75f0501b8e742b8338ea48ac99889b6efa3614bf16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-arm64.tar.gz"
      sha256 "6a974534c6ffde18c84d6c7b04aa13e7976b53f1603438cc7b32a062abb4affd"
    end
    on_intel do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-x64.tar.gz"
      sha256 "aaa426846c5d09919a972888839da2b571834a3d16a7912ccfcb781acd660d98"
    end
  end

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/panguard"
    bin.install_symlink libexec/"bin/panguard" => "pga"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panguard --version")
  end
end
