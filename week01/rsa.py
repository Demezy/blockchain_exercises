import random


def is_prime(number: int) -> bool:
    if number < 2:
        return False
    for i in range(2, int(number**0.5) + 1):
        if number % i == 0:
            return False
    return True


def generate_random_prime_number(
    min_value: int,
    max_value: int,
) -> int:
    while True:
        number = random.randint(min_value, max_value)
        if is_prime(number):
            return number
        
def string_to_int(message: str) -> int:
    result = 0
    for i, char in enumerate(message):
        result += ord(char) * 256**i
    return result

def int_to_string(number: int) -> str:
    result = ""
    while number > 0:
        result += chr(number % 256)
        number //= 256
    return result

p = generate_random_prime_number(10**3, 10**4)
q = generate_random_prime_number(10**3, 10**4)
n = p * q
e = 65537
d = 0
phi = (p - 1) * (q - 1)
while True:
    if (e * d) % phi == 1:
        break
    d += 1
print("Public key:", e, n)
print("Private key:", d, n)

# due to small n, we can encrypt only short messages
message = "hi"
print("Original message:", message)
print("Original message as int:", string_to_int(message))

cypher_text = pow(string_to_int(message), e, n)
print("Encrypted message:", cypher_text)

decrypted_message = int_to_string(pow(cypher_text, d, n))
print("Decrypted message:", decrypted_message)
