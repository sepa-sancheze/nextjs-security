import type { NextConfig } from "next";

module.exports = {
  async redirects() {
    return [
      {
        source: "/",
        destination: "/prueba-tecnica",
        permanent: true,
      },
    ];
  },
};

const nextConfig: NextConfig = {
  /* config options here */
};

export default nextConfig;
