//@ role : create key pair for generate session key
//parameter: public key,private key (BigInteger)
package SSH;
public final class KeyPair { 

    PrivateKey privateKey;
    PublicKey  publicKey;

    public KeyPair(PublicKey publicKey, PrivateKey privateKey) {
	this.publicKey = publicKey;
	this.privateKey = privateKey;
    }

    public PublicKey getPublic() {
	return publicKey;
    }

   public PrivateKey getPrivate() {
	return privateKey;
    }    
}
