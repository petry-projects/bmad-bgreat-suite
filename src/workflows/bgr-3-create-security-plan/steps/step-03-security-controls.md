# Step 3: Security Controls & Architecture

## MANDATORY EXECUTION RULES (READ FIRST):

- 🛑 NEVER generate content without user input

- 📖 CRITICAL: ALWAYS read the complete step file before taking any action - partial understanding leads to incomplete decisions
- 🔄 CRITICAL: When loading next step with 'C', ensure the entire file is read and understood before proceeding
- ✅ ALWAYS treat this as collaborative discovery between security peers
- 📋 YOU ARE A FACILITATOR, not a content generator
- 💬 FOCUS on designing security controls that mitigate identified threats
- 🎯 BUILD on the threat model from step 2
- ⚠️ ABSOLUTELY NO TIME ESTIMATES - AI development speed has fundamentally changed
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

## EXECUTION PROTOCOLS:

- 🎯 Show your analysis before taking any action
- ⚠️ Present C/R menu after generating security controls design
- 💾 ONLY save when user chooses C (Continue)
- 📖 Update frontmatter `stepsCompleted: [1, 2, 3]` before loading next step
- 🚫 FORBIDDEN to load next step until C is selected

## COLLABORATION MENUS (C/R):

This step will generate content and present choices:

- **C (Continue)**: Save the content to the document and proceed to next step
- **R (Revise)**: Discuss changes, refine the controls design, then re-present the menu

## CONTEXT BOUNDARIES:

- Current document with Threat Model from step 2 is available
- Architecture decisions and infrastructure context are loaded
- Threats identified in step 2 drive the control selection
- Focus on designing controls that address identified threats systematically

## YOUR TASK:

Design comprehensive security controls covering zero-trust architecture, network security, application security, and API security that directly mitigate the threats identified in the threat model.

## SECURITY CONTROLS DESIGN SEQUENCE:

### 1. Design Zero-Trust Architecture

Work with the user to establish zero-trust principles:

**Zero-Trust Foundations:**

- **Verify explicitly**: Always authenticate and authorize based on all available data points (identity, location, device health, service, data classification, anomalies)
- **Use least privilege access**: Limit access with just-in-time and just-enough-access (JIT/JEA), risk-based adaptive policies, and data protection
- **Assume breach**: Minimize blast radius and segment access, verify end-to-end encryption, use analytics for threat detection and posture improvement

**Architecture Components:**

- **Identity provider**: Centralized identity with strong authentication
- **Policy engine**: Real-time access decisions based on context
- **Policy enforcement points**: Service mesh, API gateway, network policies
- **Continuous monitoring**: Session validation, anomaly detection, posture assessment

**Microsegmentation Strategy:**
- Service-to-service communication policies (deny by default, allow by exception)
- Workload identity verification (mTLS, SPIFFE/SPIRE)
- Network policies aligned with trust boundaries from threat model
- East-west traffic inspection and monitoring

### 2. Design Network Security

Collaborate on network-level controls:

**Network Segmentation:**
- VPC/VNET design with isolated subnets per tier (public, application, data)
- Network ACLs and security groups per component
- Private endpoints for managed services (databases, caches, queues)
- Bastion/jump host or zero-trust network access for administrative access

**Perimeter Defense:**
- Web Application Firewall (WAF) rules and managed rule sets
- DDoS protection (volumetric, protocol, application layer)
- CDN security configuration (origin shielding, geo-restrictions)
- DNS security (DNSSEC, DNS filtering)

**Egress Controls:**
- Egress filtering with allowlisted destinations
- NAT gateway for controlled outbound access
- Proxy or firewall for external API calls
- Data Loss Prevention (DLP) at network boundary

**Internal Network Security:**
- Service mesh for mTLS between services
- Network policies for pod-to-pod communication (Kubernetes)
- Internal DNS isolation
- Traffic flow logging and analysis

### 3. Design Application Security

Collaborate on application-level controls:

**Input Validation:**
- Server-side validation for all user input (never trust client-side only)
- Parameterized queries for all database operations (SQL injection prevention)
- Content-Type validation and enforcement
- File upload restrictions (type, size, content scanning)
- Request size limits and payload validation

**Cross-Site Scripting (XSS) Prevention:**
- Content Security Policy (CSP) headers with strict directives
- Output encoding for all user-generated content
- HTTP-only and Secure flags on session cookies
- Subresource Integrity (SRI) for external scripts

**Cross-Site Request Forgery (CSRF) Prevention:**
- Anti-CSRF tokens for all state-changing operations
- SameSite cookie attribute enforcement
- Origin and Referer header validation
- Double-submit cookie pattern for API endpoints

**Security Headers:**
- `Strict-Transport-Security` (HSTS) with preload
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY` or CSP frame-ancestors
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy` for feature restrictions

**Session Management:**
- Secure session token generation (cryptographically random, sufficient entropy)
- Session timeout policies (idle timeout, absolute timeout)
- Session invalidation on privilege change or logout
- Concurrent session controls

**Error Handling:**
- Generic error messages to users (no stack traces, no internal details)
- Detailed error logging server-side (correlated with trace IDs)
- Custom error pages (no framework defaults in production)
- Graceful degradation for security control failures

### 4. Design API Security

Collaborate on API-specific controls:

**Authentication:**
- OAuth 2.0 / OpenID Connect for user-facing APIs
- API key management for service-to-service (with rotation policy)
- JWT validation (signature, issuer, audience, expiration)
- Certificate-based authentication (mTLS) for internal services

**Authorization:**
- Endpoint-level authorization checks (not just authentication)
- Resource-level access control (users can only access their own data)
- Scope-based access for OAuth tokens
- Authorization caching with appropriate TTL

**Rate Limiting & Throttling:**
- Per-client rate limits (by API key, user, IP)
- Per-endpoint rate limits (protect expensive operations)
- Global rate limits (protect infrastructure capacity)
- Graduated response: throttle before block
- Rate limit headers in responses (X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset)

**Input Validation for APIs:**
- Schema validation against OpenAPI specification
- Request payload size limits
- Query parameter sanitization
- Depth limiting for nested JSON/GraphQL queries
- Batch request limits

**API Gateway Security:**
- Centralized authentication and authorization
- Request/response transformation and sanitization
- API versioning with deprecation policy
- Audit logging for all API calls

### 5. Map Controls to Threats

Connect each control back to the threats it mitigates:

**Control-Threat Mapping:**

| Threat ID | Threat | Control(s) | Coverage | Residual Risk |
|-----------|--------|-----------|----------|---------------|
| | | | Full/Partial | |

Ensure every threat rated Critical or High risk from step 2 has at least one control mapped.

### 6. Present Security Controls Design

Reflect the controls design back to the user:

"Here's the Security Controls design I've drafted for {{project_name}}.

**Zero-Trust Architecture:**
- Identity-centric access with continuous verification
- Microsegmentation with {approach}
- mTLS for service-to-service: {yes/no}

**Network Security:**
- Segmentation: {tier count} tiers with isolated subnets
- WAF: {managed/custom rules}
- Egress controls: {allowlist/proxy approach}

**Application Security:**
- Input validation: Server-side with parameterized queries
- XSS: CSP + output encoding
- CSRF: Anti-CSRF tokens + SameSite cookies
- Security headers: {count} headers configured

**API Security:**
- Authentication: {OAuth/mTLS/API keys approach}
- Rate limiting: {per-client/per-endpoint/global}
- Schema validation: {approach}

**Threat Coverage:**
- Critical threats covered: {count}/{total}
- High threats covered: {count}/{total}

Does this cover your security needs? Anything to adjust or add?"

### 7. Generate Security Controls Content

Prepare the content to append to the document:

#### Content Structure:

```markdown
## 3. Security Controls

### 3.1 Zero-Trust Architecture

{{zero_trust_design_with_components_and_policies}}

#### Microsegmentation

{{microsegmentation_strategy_and_policies}}

### 3.2 Network Security

#### Network Segmentation

{{vpc_subnet_design_and_security_groups}}

#### Perimeter Defense

| Control | Configuration | Managed Rules | Notes |
|---------|--------------|---------------|-------|
{{perimeter_defense_entries}}

#### Egress Controls

{{egress_filtering_strategy}}

### 3.3 Application Security

#### Input Validation Standards

{{input_validation_rules_and_approaches}}

#### XSS Prevention

{{xss_prevention_controls}}

#### CSRF Prevention

{{csrf_prevention_controls}}

#### Security Headers

| Header | Value | Purpose |
|--------|-------|---------|
{{security_header_entries}}

#### Session Management

{{session_management_policies}}

### 3.4 API Security

#### Authentication & Authorization

{{api_auth_strategy}}

#### Rate Limiting

| Scope | Limit | Window | Action on Exceed | Notes |
|-------|-------|--------|-----------------|-------|
{{rate_limiting_entries}}

#### API Gateway Configuration

{{api_gateway_security_config}}

### 3.5 Control-Threat Mapping

| Threat ID | Threat | Control(s) | Coverage | Residual Risk |
|-----------|--------|-----------|----------|---------------|
{{control_threat_mapping_entries}}
```

### 8. Present Content and Menu

Show the generated content and present choices:

"I've drafted the Security Controls covering zero-trust architecture, network security, application security, and API security.

**Here's what I'll add to the security plan:**

[Show the complete markdown content from step 7]

**What would you like to do?**
[C] Continue - Save this design and proceed to identity & data protection
[R] Revise - Let's discuss changes before saving"

### 9. Handle Menu Selection

#### If 'R' (Revise):

- Discuss the user's concerns or corrections
- Update the content based on feedback
- Re-present the C/R menu with updated content

#### If 'C' (Continue):

- Append the final content to `{bgr_artifacts}/security-plan.md`
- Update frontmatter: `stepsCompleted: [1, 2, 3]`
- Load `./step-04-identity-data.md`

## APPEND TO DOCUMENT:

When user selects 'C', append the content directly to the document using the structure from step 7.

## SUCCESS METRICS:

✅ Zero-trust architecture designed with identity, policy engine, and enforcement points
✅ Microsegmentation strategy defined with service-to-service policies
✅ Network segmentation covers all tiers with perimeter and egress controls
✅ Application security addresses input validation, XSS, CSRF, and session management
✅ API security covers authentication, rate limiting, and schema validation
✅ Every Critical and High threat has at least one mapped control
✅ User confirmation of security controls design
✅ C/R menu presented and handled correctly
✅ Content properly appended to document when C selected

## FAILURE MODES:

❌ Designing controls without referencing the threat model
❌ Missing network egress controls (common oversight)
❌ Not addressing API-specific security (rate limiting, schema validation)
❌ Skipping control-to-threat mapping
❌ Not considering zero-trust principles in the design
❌ Not validating controls design with user

❌ **CRITICAL**: Reading only partial step file - leads to incomplete understanding and poor decisions
❌ **CRITICAL**: Proceeding with 'C' without fully reading and understanding the next step file
❌ **CRITICAL**: Making decisions without complete understanding of step requirements and protocols

## NEXT STEP:

After user selects 'C' and content is saved to document, load `./step-04-identity-data.md` to define identity management, secret management, and data protection strategies.

Remember: Do NOT proceed to step-04 until user explicitly selects 'C' from the C/R menu and content is saved!
