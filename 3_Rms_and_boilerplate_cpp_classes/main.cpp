#include <iostream>
#include <cmath>
#include <functional>
using namespace std;

double numerical_integration(std::function<double(double)> f,
                             double a, double b, double N = 10000) {
    double h = (b - a) / N;
    double tmp = 0;
    tmp += f(a);
    tmp += f(b);
    while(a < b) {
        tmp += 2 * f(a);
        a += h;
    }
    return (h/2)*tmp;
}

class Signal {
protected:
    using rftype =  std::function<double(double)>;
    rftype function;
public:
    Signal(rftype f): function(f) {
    }
    double output(double x) { return function(x); }
    rftype getFunction() {return function; }
};

class DcSignal: public Signal {
public:
    DcSignal(double dcValue): Signal([dcValue](double t) -> double {
        return dcValue;
    }){}
};

class AcSignal: public Signal {
public:
    AcSignal(rftype func, double p): Signal([func,p](double t) -> double {
        if(std::abs(t) <= std::abs(p)) return func(t);
        else return func(t - (int)(t/p) * p);
    }), f(1/p), p(p){}

    double getRms() {
        return std::sqrt(1/p * numerical_integration(function, 0, p));
    }

    double getFrequency() { return f; }
    double getPeriod() { return p; }
protected:
    double f, p;
};

class SinusoidalAcSignal: public AcSignal {
public:
    SinusoidalAcSignal(double amplitude, double frequency, double phase = 0):
        AcSignal([amplitude, frequency, phase](double t) -> double {
            return amplitude * std::sin(t*2*3.14159268*frequency + phase);
    }, 1/frequency), a(amplitude) {}

    double getRms() { return a/std::sqrt(2); }
    double getAmplitude() { return a; }
private:
    double a;
};


int main()
{
    SinusoidalAcSignal s(2, 2);
    cout << s.getRms() << '\n';
    cout << s.output(2.5) << '\n';
    return 0;
}
