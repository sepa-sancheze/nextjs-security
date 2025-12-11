# Next.js Security Project

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app) and configured with comprehensive security features.

## Getting Started

### Development

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3007](http://localhost:3007) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

### Production

Build and start the production server:

```bash
pnpm build
pnpm start
```

### Docker

Build and run with Docker:

```bash
docker-compose up --build
```

The application will be available at [http://localhost](http://localhost).

## Security Configuration

This project is configured with multiple layers of security:

### Security Headers

The nginx configuration (`nginx/default.conf`) includes comprehensive security headers:

- **X-Frame-Options**: Prevents clickjacking attacks
- **X-Content-Type-Options**: Prevents MIME type sniffing
- **X-XSS-Protection**: Enables XSS filtering
- **Referrer-Policy**: Controls referrer information
- **Cross-Origin-Resource-Policy**: Prevents cross-origin resource sharing
- **Permissions-Policy**: Controls browser feature permissions
- **Content-Security-Policy**: Comprehensive CSP to prevent XSS and injection attacks

### Container Security Scanning

**Image vulnerability scans are automatically performed and results are available in the GitHub Security tab.**

The CI/CD pipeline includes:

- **Trivy Security Scanner**: Scans Docker images for vulnerabilities
- **Critical/High Severity Focus**: Only reports critical and high severity issues
- **GitHub Security Integration**: Results are uploaded to GitHub's Security tab for easy monitoring
- **Automated Scanning**: Runs on every push to main branch

### Secret Management

**All secrets are securely managed using Doppler.**

The following secrets are configured in Doppler and used in the deployment pipeline:

- `AWS_ACCESS_KEY_ID`: AWS access credentials
- `AWS_SECRET_ACCESS_KEY`: AWS secret credentials
- `AWS_REGION`: AWS deployment region
- `ECR_REPOSITORY`: ECR repository name
- `APPLICATION_NAME`: Elastic Beanstalk application name
- `ENVIRONMENT_NAME`: Elastic Beanstalk environment name

### Local Security Scanning

Run local security scans:

```bash
# Scan for vulnerabilities in dependencies and filesystem
pnpm run scan:security
```

## Architecture

### Container Setup

- **Multi-stage Docker build** for optimized image size
- **Nginx + Next.js** setup with supervisor for process management
- **Alpine Linux base** for minimal attack surface
- **Non-root user** execution for container security

### Deployment Pipeline

1. **Build & Push**: Docker image built and pushed to Amazon ECR
2. **Security Scan**: Trivy scans the built image for vulnerabilities
3. **Security Report**: Results uploaded to GitHub Security tab
4. **Deploy**: Automated deployment to AWS Elastic Beanstalk

## Monitoring Security

### GitHub Security Tab

All security scan results are automatically uploaded to GitHub's Security tab, where you can:

- View vulnerability reports from Trivy scans
- Track security issues over time
- Receive notifications for new vulnerabilities
- Monitor fix progress

### Security Workflow

The deployment workflow (`.github/workflows/deploy.yml`) includes:

1. Container image vulnerability scanning with Trivy
2. SARIF format results uploaded to GitHub Security
3. Table format output for CI logs
4. Automated security reporting

## Security Best Practices

This project implements:

- **Secure defaults** in nginx configuration
- **Automated vulnerability scanning** in CI/CD
- **Secret management** with Doppler
- **Security headers** for web protection
- **Container hardening** with Alpine Linux
- **Multi-stage builds** to reduce attack surface

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deployment

This application is configured for deployment on AWS Elastic Beanstalk using Docker containers. The deployment process is fully automated through GitHub Actions and includes comprehensive security scanning.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
