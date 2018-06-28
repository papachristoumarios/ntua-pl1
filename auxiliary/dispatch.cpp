#include <iostream>
using namespace std;

class B {
public:
  int x;
  B() {
    x = 42;
  }
  // dynamic
  virtual void f() {
      cout << x << endl;
  }

  // static
  void g() {
    cout << x << endl;
  }

};

class D : public B {
public:
  int x;
  D() {
    x = 17;
  }
  void f() {
    cout << x << endl;
  }

  void g() {
    cout << x << endl;
  }

};

int main() {
  cout << "Dynamic" << endl;
  B *b = new B();
  b->f();
  B *d = new D();
  d->f();
  cout << "Static" << endl;
  b->g();
  d->g();

}
