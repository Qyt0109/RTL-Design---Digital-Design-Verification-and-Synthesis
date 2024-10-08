{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil\fcharset0 Courier New;}}
{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\lang1033\f0\fs22 -- Declaration of a procedure in a package\par
--\par
-- /procedure_package_1.vhd\par
--\par
package PKG is\par
    procedure ADD (\par
        A, B, CIN : in BIT;\par
        C : out BIT_VECTOR (1 downto 0) );\par
end PKG;\par
\par
package body PKG is\par
    procedure ADD (\par
        A, B, CIN : in BIT;\par
        C : out BIT_VECTOR (1 downto 0)\par
\tab ) is\par
        variable S, COUT : BIT;\par
    begin\par
        S := A xor B xor CIN;\par
        COUT := (A and B) or (A and CIN) or (B and CIN);\par
        C := COUT & S;\par
    end ADD;\par
end PKG;\par
\par
use work.PKG.all;\par
\par
entity EXAMPLE is\par
    port (\par
        A,B : in BIT_VECTOR (3 downto 0);\par
        CIN : in BIT;\par
        S : out BIT_VECTOR (3 downto 0);\par
        COUT : out BIT );\par
end EXAMPLE;\par
\par
architecture ARCHI of EXAMPLE is\par
begin\par
    process (A,B,CIN)\par
        variable S0, S1, S2, S3 : BIT_VECTOR (1 downto 0);\par
    begin\par
        ADD (A(0), B(0), CIN, S0);\par
        ADD (A(1), B(1), S0(1), S1);\par
        ADD (A(2), B(2), S1(1), S2);\par
        ADD (A(3), B(3), S2(1), S3);\par
        S <= S3(0) & S2(0) & S1(0) & S0(0);\par
        COUT <= S3(1);\par
    end process;\par
end ARCHI;\par
}
 