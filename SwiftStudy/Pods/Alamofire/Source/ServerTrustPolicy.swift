//
//  ServerTrustPolicy.swift
//
//  Copyright (c) 2014 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/*
 服务端和前端建立SSL认证的基础。
 HTTPS安全认证。
 1、当我们以https：//进行网络请求的时候。前端和服务器都需要一个证书，因为URLSession自带一个根证书，所以我们进行https请求的时候感觉没做什么操作，其实
    苹果内部已经加载了一个根证书。
 2、服务器的证书可以从证书机构获取，也可以自己生成。如果从证书机构获取，那么是不需要做任何操作的，URLSeeion自带的根证书一定会验证通过同样代理方法也不会调用（didReciveChanllenge）。如果是自己创建的证书就需要客户端进行验证（证书里面有公钥和私钥），那么客户端需要一个证书用来对比服务端发送的证书来确保服务端可信：
    a、公钥是公开的，任何人都可以通过公钥对数据进行加密。
    b、私钥是保密的，只有拥有私钥的人才能对加密数据进行解密。其实这就是非对称加密。
    
 认证过程：
 1、发送https请求。如果服务器证书是证书机构颁发的，那么直接就不会走URLSession的回调直接验证通过。如果是自己生成的证书那么会往下走。
 2、服务器将公钥发给客户端。
 3、客户端拿到公钥，这个时候并不会直接用公钥进行加密传送，因为服务端这个时候没法给客户端发送数据（因为客户端没有私钥，如果服务端用公钥对数据进行加密发送，客户端拿到数据也没用）。那么就需要客户端和服务端建立一个安全通道，客户端会生成一个随机密码，然后用公钥给随机密码加密，然后发给服务端，服务端用私钥进行解密拿到随机密码，然后用随机密码对传输数据进行对称加密，这样安全通过就建立了。
 所以说认证过程其实是非对称加密和对称加密共同作用的结果。
    
 */
import Foundation

/// Responsible for managing the mapping of `ServerTrustPolicy` objects to a given host.
open class ServerTrustPolicyManager {
    
    /*
     通过不同的host来绑定不同的安全策略。而URLSession会绑定一个ServerTrustPolicyManager。
     let serverTrustPolicies: [String: ServerTrustPolicy] = [
         "test.example.com": .pinCertificates(
             certificates: ServerTrustPolicy.certificates(),
             validateCertificateChain: true,
             validateHost: true
         ),
         "insecure.expired-apis.com": .disableEvaluation
     ]

     let serverTrustManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
     
     */
    /// The dictionary of policies mapped to a particular host.
    public let policies: [String: ServerTrustPolicy]

    /// Initializes the `ServerTrustPolicyManager` instance with the given policies.
    ///
    /// Since different servers and web services can have different leaf certificates, intermediate and even root
    /// certficates, it is important to have the flexibility to specify evaluation policies on a per host basis. This
    /// allows for scenarios such as using default evaluation for host1, certificate pinning for host2, public key
    /// pinning for host3 and disabling evaluation for host4.
    ///
    /// - parameter policies: A dictionary of all policies mapped to a particular host.
    ///
    /// - returns: The new `ServerTrustPolicyManager` instance.
    public init(policies: [String: ServerTrustPolicy]) {
        self.policies = policies
    }

    /// Returns the `ServerTrustPolicy` for the given host if applicable.
    ///
    /// By default, this method will return the policy that perfectly matches the given host. Subclasses could override
    /// this method and implement more complex mapping implementations such as wildcards.
    ///
    /// - parameter host: The host to use when searching for a matching policy.
    ///
    /// - returns: The server trust policy for the given host if found.
    open func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return policies[host]
    }
}

// MARK: -

extension URLSession {
    private struct AssociatedKeys {
        static var managerKey = "URLSession.ServerTrustPolicyManager"
    }

    var serverTrustPolicyManager: ServerTrustPolicyManager? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.managerKey) as? ServerTrustPolicyManager
        }
        set (manager) {
            objc_setAssociatedObject(self, &AssociatedKeys.managerKey, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - ServerTrustPolicy

/// The `ServerTrustPolicy` evaluates the server trust generally provided by an `NSURLAuthenticationChallenge` when
/// connecting to a server over a secure HTTPS connection. The policy configuration then evaluates the server trust
/// with a given set of criteria to determine whether the server trust is valid and the connection should be made.
///
/// Using pinned certificates or public keys for evaluation helps prevent man-in-the-middle (MITM) attacks and other
/// vulnerabilities. Applications dealing with sensitive customer data or financial information are strongly encouraged
/// to route all communication over an HTTPS connection with pinning enabled.
///
/// - performDefaultEvaluation: Uses the default server trust evaluation while allowing you to control whether to
///                             validate the host provided by the challenge. Applications are encouraged to always
///                             validate the host in production environments to guarantee the validity of the server's
///                             certificate chain.
///
/// - performRevokedEvaluation: Uses the default and revoked server trust evaluations allowing you to control whether to
///                             validate the host provided by the challenge as well as specify the revocation flags for
///                             testing for revoked certificates. Apple platforms did not start testing for revoked
///                             certificates automatically until iOS 10.1, macOS 10.12 and tvOS 10.1 which is
///                             demonstrated in our TLS tests. Applications are encouraged to always validate the host
///                             in production environments to guarantee the validity of the server's certificate chain.
///
/// - pinCertificates:          Uses the pinned certificates to validate the server trust. The server trust is
///                             considered valid if one of the pinned certificates match one of the server certificates.
///                             By validating both the certificate chain and host, certificate pinning provides a very
///                             secure form of server trust validation mitigating most, if not all, MITM attacks.
///                             Applications are encouraged to always validate the host and require a valid certificate
///                             chain in production environments.
///
/// - pinPublicKeys:            Uses the pinned public keys to validate the server trust. The server trust is considered
///                             valid if one of the pinned public keys match one of the server certificate public keys.
///                             By validating both the certificate chain and host, public key pinning provides a very
///                             secure form of server trust validation mitigating most, if not all, MITM attacks.
///                             Applications are encouraged to always validate the host and require a valid certificate
///                             chain in production environments.
///
/// - disableEvaluation:        Disables all evaluation which in turn will always consider any server trust as valid.
///
/// - customEvaluation:         Uses the associated closure to evaluate the validity of the server trust.

/*
 核心代码。安全策略。
 
 */
public enum ServerTrustPolicy {
    case performDefaultEvaluation(validateHost: Bool)
    case performRevokedEvaluation(validateHost: Bool, revocationFlags: CFOptionFlags)
    case pinCertificates(certificates: [SecCertificate], validateCertificateChain: Bool, validateHost: Bool)
    case pinPublicKeys(publicKeys: [SecKey], validateCertificateChain: Bool, validateHost: Bool)
    case disableEvaluation
    case customEvaluation((_ serverTrust: SecTrust, _ host: String) -> Bool)

    // MARK: - Bundle Location

    /// Returns all certificates within the given bundle with a `.cer` file extension.
    ///
    /// - parameter bundle: The bundle to search for all `.cer` files.
    ///
    /// - returns: All certificates within the given bundle.
    /*
     获取证书。
     */
    public static func certificates(in bundle: Bundle = Bundle.main) -> [SecCertificate] {
        var certificates: [SecCertificate] = []

        let paths = Set([".cer", ".CER", ".crt", ".CRT", ".der", ".DER"].map { fileExtension in
            bundle.paths(forResourcesOfType: fileExtension, inDirectory: nil)
        }.joined())

        for path in paths {
            if
                let certificateData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData,
                let certificate = SecCertificateCreateWithData(nil, certificateData)
            {
                certificates.append(certificate)
            }
        }

        return certificates
    }

    /// Returns all public keys within the given bundle with a `.cer` file extension.
    ///
    /// - parameter bundle: The bundle to search for all `*.cer` files.
    ///
    /// - returns: All public keys within the given bundle.
    /*
    获取公钥。
     */
    public static func publicKeys(in bundle: Bundle = Bundle.main) -> [SecKey] {
        var publicKeys: [SecKey] = []

        for certificate in certificates(in: bundle) {
            if let publicKey = publicKey(for: certificate) {
                publicKeys.append(publicKey)
            }
        }

        return publicKeys
    }

    // MARK: - Evaluation

    /// Evaluates whether the server trust is valid for the given host.
    ///
    /// - parameter serverTrust: The server trust to evaluate.
    /// - parameter host:        The host of the challenge protection space.
    ///
    /// - returns: Whether the server trust is valid.
    public func evaluate(_ serverTrust: SecTrust, forHost host: String) -> Bool {
        var serverTrustIsValid = false

        switch self {
        case let .performDefaultEvaluation(validateHost):
            let policy = SecPolicyCreateSSL(true, validateHost ? host as CFString : nil)
            SecTrustSetPolicies(serverTrust, policy)

            serverTrustIsValid = trustIsValid(serverTrust)
        case let .performRevokedEvaluation(validateHost, revocationFlags):
            let defaultPolicy = SecPolicyCreateSSL(true, validateHost ? host as CFString : nil)
            let revokedPolicy = SecPolicyCreateRevocation(revocationFlags)
            SecTrustSetPolicies(serverTrust, [defaultPolicy, revokedPolicy] as CFTypeRef)

            serverTrustIsValid = trustIsValid(serverTrust)
        case let .pinCertificates(pinnedCertificates, validateCertificateChain, validateHost):
            if validateCertificateChain {
                let policy = SecPolicyCreateSSL(true, validateHost ? host as CFString : nil)
                SecTrustSetPolicies(serverTrust, policy)

                SecTrustSetAnchorCertificates(serverTrust, pinnedCertificates as CFArray)
                SecTrustSetAnchorCertificatesOnly(serverTrust, true)

                serverTrustIsValid = trustIsValid(serverTrust)
            } else {
                let serverCertificatesDataArray = certificateData(for: serverTrust)
                let pinnedCertificatesDataArray = certificateData(for: pinnedCertificates)

                outerLoop: for serverCertificateData in serverCertificatesDataArray {
                    for pinnedCertificateData in pinnedCertificatesDataArray {
                        if serverCertificateData == pinnedCertificateData {
                            serverTrustIsValid = true
                            break outerLoop
                        }
                    }
                }
            }
        case let .pinPublicKeys(pinnedPublicKeys, validateCertificateChain, validateHost):
            var certificateChainEvaluationPassed = true

            if validateCertificateChain {
                let policy = SecPolicyCreateSSL(true, validateHost ? host as CFString : nil)
                SecTrustSetPolicies(serverTrust, policy)

                certificateChainEvaluationPassed = trustIsValid(serverTrust)
            }

            if certificateChainEvaluationPassed {
                outerLoop: for serverPublicKey in ServerTrustPolicy.publicKeys(for: serverTrust) as [AnyObject] {
                    for pinnedPublicKey in pinnedPublicKeys as [AnyObject] {
                        if serverPublicKey.isEqual(pinnedPublicKey) {
                            serverTrustIsValid = true
                            break outerLoop
                        }
                    }
                }
            }
        case .disableEvaluation:
            serverTrustIsValid = true
        case let .customEvaluation(closure):
            serverTrustIsValid = closure(serverTrust, host)
        }

        return serverTrustIsValid
    }

    // MARK: - Private - Trust Validation

    private func trustIsValid(_ trust: SecTrust) -> Bool {
        var isValid = false

        if #available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *) {
            isValid = SecTrustEvaluateWithError(trust, nil)
        } else {
            var result = SecTrustResultType.invalid
            let status = SecTrustEvaluate(trust, &result)

            if status == errSecSuccess {
                let unspecified = SecTrustResultType.unspecified
                let proceed = SecTrustResultType.proceed

                isValid = result == unspecified || result == proceed
            }
        }

        return isValid
    }

    // MARK: - Private - Certificate Data

    private func certificateData(for trust: SecTrust) -> [Data] {
        var certificates: [SecCertificate] = []

        for index in 0..<SecTrustGetCertificateCount(trust) {
            if let certificate = SecTrustGetCertificateAtIndex(trust, index) {
                certificates.append(certificate)
            }
        }

        return certificateData(for: certificates)
    }

    private func certificateData(for certificates: [SecCertificate]) -> [Data] {
        return certificates.map { SecCertificateCopyData($0) as Data }
    }

    // MARK: - Private - Public Key Extraction

    private static func publicKeys(for trust: SecTrust) -> [SecKey] {
        var publicKeys: [SecKey] = []

        for index in 0..<SecTrustGetCertificateCount(trust) {
            if
                let certificate = SecTrustGetCertificateAtIndex(trust, index),
                let publicKey = publicKey(for: certificate)
            {
                publicKeys.append(publicKey)
            }
        }

        return publicKeys
    }

    private static func publicKey(for certificate: SecCertificate) -> SecKey? {
        var publicKey: SecKey?

        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)

        if let trust = trust, trustCreationStatus == errSecSuccess {
            publicKey = SecTrustCopyPublicKey(trust)
        }

        return publicKey
    }
}
