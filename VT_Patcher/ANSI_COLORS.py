# ============  VT_YC ANSI COLORS  ============
# Developer: \U0001d75f\U0001f5b8\U0001f5f3\U0001f5f0\u0970\U0001d75c4
# Channel: @VT_YC

class ANSI:
    def __init__(self):

        self.ESC = '\033'

        # ANSI COLOR ( BOLD = 1m | DARK = 2m )
        self.R  = self.ESC + '[31;1m'  # RED
        self.G  = self.ESC + '[32;1m'  # GREEN
        self.Y  = self.ESC + '[33;1m'  # YELLOW
        self.B  = self.ESC + '[34;1m'  # BLUE
        self.P  = self.ESC + '[35;1m'  # PURPLE
        self.C  = self.ESC + '[36;1m'  # CYAN
        self.W  = self.ESC + '[37;1m'  # WHITE

        # BRIGHT COLOR
        self.BR = self.ESC + '[91;1m'  # BRIGHT RED
        self.BG = self.ESC + '[92;1m'  # BRIGHT GREEN
        self.BY = self.ESC + '[93;1m'  # BRIGHT YELLOW
        self.BB = self.ESC + '[94;1m'  # BRIGHT BLUE
        self.BP = self.ESC + '[95;1m'  # BRIGHT PURPLE
        self.BC = self.ESC + '[96;1m'  # BRIGHT CYAN
        self.BW = self.ESC + '[97;1m'  # BRIGHT WHITE

        # OTHER COLOR
        self.DG = self.ESC + '[32;2m'  # DARK GREEN
        self.GR = self.ESC + '[90;1m'  # GRAY

        # 256 Colors
        self.PN = self.ESC + '[38;5;213;1m'  # PINK
        self.OG = self.ESC + '[38;5;202;1m'  # ORANGE

        # CLEAR CODES
        self.CL  = self.ESC + '[2K'  # CLEAR LINE
        self.CC  = self.ESC + '[0m'  # CLEAR COLOR

        # TAG
        self.S = f'{self.B}[{self.C}'
        self.E = f'{self.B}]'
        self.X = f'{self.B}[ {self.P}* {self.B}]'
        self.FYI = f'{self.B}[ {self.P}FYI {self.B}]'
        self.INFO = f'{self.B}[ {self.Y}INFO {self.B}]{self.C}'
        self.WARN = f'{self.B}[ {self.Y}WARN {self.B}]{self.B}'
        self.ERROR = f'{self.B}[ {self.R}ERROR {self.B}]{self.R}'
        self.SUGGEST = f'{self.B}[ {self.Y}SUGGEST {self.B}]{self.C}'
