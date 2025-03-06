## Fingerprint for sudo sessions
If you want to use your fingerprint as a way of confirming sudo commands:

- `sudo nano /etc/pam.d/sudo`
- add `auth sufficient pam_tid.so`
