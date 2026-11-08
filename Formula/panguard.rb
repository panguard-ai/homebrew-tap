class Panguard < Formula
  desc "Security platform for AI agents - scan, audit, and protect AI skills"
  homepage "https://panguard.ai"
  version "1.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-darwin-arm64.tar.gz"
      sha256 "00b6b0af8dd12f20dd6740d8e27871ec27d76fcfd8f9052c4e169450bb2634e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-arm64.tar.gz"
      sha256 "849eb8a931bc644079eef5b53f722f07c0f60fb1cdf2198558a4ccabe2ea8543"
    end
    on_intel do
      url "https://github.com/panguard-ai/panguard-ai/releases/download/v#{version}/panguard-linux-x64.tar.gz"
      sha256 "69c85072b84fd04deb45431ee1dd7f09a732221d48d3dbdb2b48d9e8dc3eada9"
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
