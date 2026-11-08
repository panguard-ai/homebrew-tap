class Panguard < Formula
  desc "Security platform for AI agents - scan, audit, and protect AI skills"
  homepage "https://panguard.ai"
  version "1.10.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-darwin-arm64.tar.gz"
      sha256 "4f8cc325b9223ba9cc13ad7e2cfc937864b5eb20f8a9223bfe6f4d7dd23d8cb7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-arm64.tar.gz"
      sha256 "c3a28d687a0aec4c1745dc3e41769dc83dd326347a292dd7a8c9eb6cffa2c42d"
    end
    on_intel do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-x64.tar.gz"
      sha256 "ca2d014208a83152f181265c26c555f08076bf584b39887bf6f645c9ff1d93f4"
    end
  end

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    # Write wrapper scripts that resolve the real path (not symlink)
    (bin/"panguard").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/dist/cli/index.js" "$@"
    BASH
    (bin/"pga").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/dist/cli/index.js" "$@"
    BASH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/panguard --version")
  end
end
