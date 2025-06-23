#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Jun 21 00:43:57 2020
@author: Debapriya
"""
import os
import sys
import argparse
#import gmpy2
from random import randint
import numpy as np
#from scipy.ndimage.interpolation import shift
import math
def ADD(instr):
    opcode=0
    funct=0
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def SUB(instr):
    opcode=0
    funct=1
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def ADDU(instr):
    opcode=0
    funct=2
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def SUBU(instr):
    opcode=0
    funct=3
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def MADD(instr):
    opcode=0
    funct=4
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def MADDU(instr):
    opcode=0
    funct=5
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def MUL(instr):
    opcode=0
    funct=6
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def AND(instr):
    opcode=0
    funct=7
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def OR(instr):
    opcode=0
    funct=8
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def NOT(instr):
    opcode=0
    funct=9
    instr=instr.strip()
    str_list=instr.split(',')
    rs=int(str_list[1])
    rd=int(str_list[0])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def XOR(instr):
    opcode=0
    funct=10
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def SLT(instr):
    opcode=0
    funct=11
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def SLL(instr):
    opcode=0
    funct=12
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    shamt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(shamt,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5

def SRL(instr):
    opcode=0
    funct=13
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    shamt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(shamt,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5

def SLA(instr):
    opcode=0
    funct=14
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    shamt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(shamt,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5
def SRA(instr):
    opcode=0
    funct=15
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    shamt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(shamt,5)
    instr_val_5 =np.binary_repr(funct,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4+instr_val_5

def ADDI(instr):
    opcode=33
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def ADDIU(instr):
    opcode=34
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def ANDI(instr):
    opcode=35
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def ORI(instr):
    opcode=36
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def XORI(instr):
    opcode=37
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def LW(instr):
    opcode = 38
    instr = instr.strip()
    rt_part, offset_part = instr.split(',')
    rt = int(rt_part.strip())
    offset_str, rs_str = offset_part.strip().split('(')
    offset = int(offset_str.strip())
    rs = int(rs_str.strip(')'))
    instr_val_0 = np.binary_repr(opcode, 6)
    instr_val_1 = np.binary_repr(rs, 5)
    instr_val_2 = np.binary_repr(rt, 5)
    instr_val_3 = np.binary_repr(offset, 16)

    return instr_val_0 + instr_val_1 + instr_val_2 + instr_val_3

def SW(instr):
    opcode=39
    instr = instr.strip()
    rt_part, offset_part = instr.split(',')
    rt = int(rt_part.strip())
    offset_str, rs_str = offset_part.strip().split('(')
    offset = int(offset_str.strip())
    rs = int(rs_str.strip(')'))
    instr_val_0 = np.binary_repr(opcode, 6)
    instr_val_1 = np.binary_repr(rs, 5)
    instr_val_2 = np.binary_repr(rt, 5)
    instr_val_3 = np.binary_repr(offset, 16)

    return instr_val_0 + instr_val_1 + instr_val_2 + instr_val_3
def LUI(instr):
    opcode=40
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    imm=int(str_list[1])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(0,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(imm,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3
def BEQ(instr):
    opcode=41
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BNE(instr):
    opcode=42
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BGT(instr):
    opcode=43
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BGTE(instr):
    opcode=44
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BLE(instr):
    opcode=45
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BLEQ(instr):
    opcode=46
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BLEU(instr):
    opcode=47
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def BGTU(instr):
    opcode=48
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def SLTI(instr):
    opcode=49
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def SEQ(instr):
    opcode=50
    instr=instr.strip()
    str_list=instr.split(',')
    rt=int(str_list[0])
    rs=int(str_list[1])
    immi=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(immi,16)

    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def JUMP(instr):
    opcode=17
    target=int(instr.strip())
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(target,26)

    return instr_val_0+instr_val_1

def JAL(instr):
    opcode=19
    target=int(instr.strip())
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(target,26)

    return instr_val_0+instr_val_1

def JR(instr):
    opcode=18
    instr=instr.strip()
    # str_list=instr.split(',')
    rs=int(instr)
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,15)
    instr_val_3 =np.binary_repr(0,6)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3

def ADD_S(instr):
    opcode=1
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def SUB_S(instr):
    opcode=2
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def CEQ_S(instr):
    opcode=3
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def CLE_S(instr):
    opcode=4
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def CLT_S(instr):
    opcode=5
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def CGE_S(instr):
    opcode=6
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def CGT_S(instr):
    opcode=7
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    rt=int(str_list[2])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(rt,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def MOV_S(instr):
    opcode=8
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def MFC1(instr):
    opcode=9
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4
def MTC1(instr):
    opcode=10
    instr=instr.strip()
    str_list=instr.split(',')
    rd=int(str_list[0])
    rs=int(str_list[1])
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(rs,5)
    instr_val_2 =np.binary_repr(0,5)
    instr_val_3 =np.binary_repr(rd,5)
    instr_val_4 =np.binary_repr(0,11)
    return instr_val_0+instr_val_1+instr_val_2+instr_val_3+instr_val_4

def FINISH(instr): # NOT YET DONE
    opcode=0x3f
    instr_val_0 =np.binary_repr(opcode,6)
    instr_val_1 =np.binary_repr(0,26)
    return instr_val_0+instr_val_1

file_a=open("machine_code.txt","w")

file_b=open("assembly.txt")
Instrs=file_b.readlines()
for instrs in Instrs:
    if(instrs[0:4]=="add "):
        ret_instr=ADD(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="sub "):
        ret_instr=SUB(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="addu "):
        ret_instr=ADDU(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="subu "):
        ret_instr=SUBU(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="madd "):
        ret_instr=MADD(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:6]=="maddu "):
        ret_instr=MADDU(instrs[6:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="mul "):
        ret_instr=MUL(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="and "):
        ret_instr=AND(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:3]=="or "):
        ret_instr=OR(instrs[3:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="not "):
        ret_instr=NOT(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="xor "):
        ret_instr=XOR(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="slt "):
        ret_instr=SLT(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="sll "):
        ret_instr=SLL(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="srl "):
        ret_instr=SRL(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="sla "):
        ret_instr=SLA(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="sra "):
        ret_instr=SRA(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="addi "):
        ret_instr=ADDI(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:6]=="addiu "):
        ret_instr=ADDIU(instrs[6:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="andi "):
        ret_instr=ANDI(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="ori "):
        ret_instr=ORI(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="xori "):
        ret_instr=XORI(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:3]=="lw "):
        ret_instr=LW(instrs[3:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:3]=="sw "):
        ret_instr=SW(instrs[3:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="lui "):
        ret_instr=LUI(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="beq "):
        ret_instr=BEQ(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="bne "):
        ret_instr=BNE(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="bgt "):
        ret_instr=BGT(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="bgte "):
        ret_instr=BGTE(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="ble "):
        ret_instr=BLE(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="bleq "):
        ret_instr=BLEQ(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="bleu "):
        ret_instr=BLEU(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="bgtu "):
        ret_instr=BGTU(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="slti "):
        ret_instr=SLTI(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="seq "):
        ret_instr=SEQ(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:6]=="add.s "):
        ret_instr=ADD_S(instrs[6:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:6]=="sub.s "):
        ret_instr=SUB_S(instrs[6:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:7]=="c.eq.s "):
        ret_instr=CEQ_S(instrs[7:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:7]=="c.le.s "):
        ret_instr=CLE_S(instrs[7:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:7]=="c.lt.s "):
        ret_instr=CLT_S(instrs[7:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:7]=="c.ge.s "):
        ret_instr=CGE_S(instrs[7:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:7]=="c.gt.s "):
        ret_instr=CGT_S(instrs[7:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:6]=="mov.s "):
        ret_instr=MOV_S(instrs[6:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="mfc1 "):
        ret_instr=MFC1(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:5]=="mtc1 "):
        ret_instr=MTC1(instrs[5:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:2]=="j "):
        ret_instr=JUMP(instrs[2:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:3]=="jr "):
        ret_instr=JR(instrs[3:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:4]=="jal "):
        ret_instr=JAL(instrs[4:-1])
        file_a.write(ret_instr + '\n')
    elif(instrs[0:8]=="finish"):
        ret_instr=FINISH(instrs[8:-1])
        file_a.write(ret_instr + '\n')
    else:
        print(instrs[0:14])
        print("danger danger undefined instruction!!!!")

file_a.close()
file_b.close()
