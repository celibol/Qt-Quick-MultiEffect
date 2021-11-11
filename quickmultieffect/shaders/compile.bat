:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Copyright (C) 2021 The Qt Company Ltd.
:: Contact: https://www.qt.io/licensing/
::
:: This file is part of the Qt Quick MultiEffect module of the Qt Toolkit.
::
:: $QT_BEGIN_LICENSE:LGPL$
:: Commercial License Usage
:: Licensees holding valid commercial Qt licenses may use this file in
:: accordance with the commercial license agreement provided with the
:: Software or, alternatively, in accordance with the terms contained in
:: a written agreement between you and The Qt Company. For licensing terms
:: and conditions see https://www.qt.io/terms-conditions. For further
:: information use the contact form at https://www.qt.io/contact-us.
::
:: GNU Lesser General Public License Usage
:: Alternatively, this file may be used under the terms of the GNU Lesser
:: General Public License version 3 as published by the Free Software
:: Foundation and appearing in the file LICENSE.LGPL3 included in the
:: packaging of this file. Please review the following information to
:: ensure the GNU Lesser General Public License version 3 requirements
:: will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
::
:: GNU General Public License Usage
:: Alternatively, this file may be used under the terms of the GNU
:: General Public License version 2.0 or (at your option) the GNU General
:: Public license version 3 or any later version approved by the KDE Free
:: Qt Foundation. The licenses are as published by the Free Software
:: Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
:: included in the packaging of this file. Please review the following
:: information to ensure the GNU General Public License requirements will
:: be met: https://www.gnu.org/licenses/gpl-2.0.html and
:: https://www.gnu.org/licenses/gpl-3.0.html.
::
:: $QT_END_LICENSE$
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Multieffect fragment shaders ::
:: c = Common color effects
:: m = Mask
:: b = Blur
:: s = Shadow
:: [n] = Amount of blur items used

qsb --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_c0.frag.qsb multieffect.frag
qsb -DMASK --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cm0.frag.qsb multieffect.frag

:: Special shaders for non-blurred shadows
qsb -DBL0 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs0.frag.qsb multieffect.frag
qsb -DBL0 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms0.frag.qsb multieffect.frag

:: Shaders for different blur levels
qsb -DBL1 -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cb1.frag.qsb multieffect.frag
qsb -DBL1 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs1.frag.qsb multieffect.frag
qsb -DBL1 -DMASK -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmb1.frag.qsb multieffect.frag
qsb -DBL1 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms1.frag.qsb multieffect.frag
qsb -DBL1 -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cbs1.frag.qsb multieffect.frag
qsb -DBL1 -DMASK -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmbs1.frag.qsb multieffect.frag

qsb -DBL1 -DBL2 -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cb2.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs2.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DMASK -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmb2.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms2.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cbs2.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DMASK -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmbs2.frag.qsb multieffect.frag

qsb -DBL1 -DBL2 -DBL3 -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cb3.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs3.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DMASK -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmb3.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms3.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cbs3.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DMASK -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmbs3.frag.qsb multieffect.frag

qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cb4.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs4.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DMASK -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmb4.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms4.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cbs4.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DMASK -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmbs4.frag.qsb multieffect.frag

qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cb5.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs5.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DMASK -DBLUR --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmb5.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DMASK -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cms5.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cbs5.frag.qsb multieffect.frag
qsb -DBL1 -DBL2 -DBL3 -DBL4 -DBL5 -DMASK -DBLUR -DSHADOW --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cmbs5.frag.qsb multieffect.frag

:: Multieffect vertex shaders ::
qsb -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_c.vert.qsb multieffect.vert
qsb -DSHADOW -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o multieffect_cs.vert.qsb multieffect.vert

:: Bluritems shaders ::
qsb --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o bluritems.frag.qsb bluritems.frag
qsb -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -O -c -o bluritems.vert.qsb bluritems.vert
