*** Settings ***
Documentation    AtMonochromator_InternalCommand communications tests.
Force Tags    python    TSS-2724
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 84 147 252 122 54 47 147 130 51 79 31 139 70 71 211 153 64 244 233 139 67 172 100 176 209 14 193 135 241 224 102 168 70 134 189 19 204 254 100 79 36 139 195 144 177 32 151 214 165 234 149 164 217 74 62 111 69 4 153 40 21 133 18 117 203 158 247 23 100 129 183 112 229 234 130 53 221 165 83 96 11 218 174 202 239 43 244 105 120 241 67 4 122 165 137 20 107 254 148 157 217 24 92 114 215 233 40 79 130 177 184 67 230 172 215 197 101 38 226 212 56 74 106 27 124 65 93 80 33 135 44 212 236 171 83 7 77 170 75 103 148 242 33 14 225 138 203 102 84 236 181 84 225 95 164 209 222 11 46 67 242 72 19 9 189 37 90 74 30 226 58 194 86 82 201 137 217 246 36 216 250 223 128 40 107 220 207 64 219 104 139 208 226 49 247 83 2 179 148 152 91 174 143 234 183 102 7 183 65 222 38 222 38 120 241 75 49 45 210 109 147 142 81 116 201 43 185 170 118 165 159 78 21 35 164 44 164 14 223 180 240 168 38 232 54 234 170 86 224 108 77 162 169 134 79 156 224 121 199 81 244 90 93 213 63 66 200 28 18 3 10 157 55 251 157 161 246 178 30 108 222 91 162 157 123 54 163 200 91 101 95 161 155 117 115 87 228 177 52 45 23 194 37 163 239 135 86 221 158 118 222 217 155 239 57 134 55 83 43 165 116 8 214 9 35 225 77 42 142 254 109 254 18 157 60 125 254 169 242 38 50 240 81 57 114 151 225 182 149 236 172 89 143 129 92 11 201 250 51 90 217 134 132 57 130 79 100 36 116 126 113 52 14 222 249 136 208 192 39 3 135 98 120 239 57 249 155 119 125 43 214 189 170 86 233 129 169 151 218 165 166 205 82 245 108 33 31 53 134 230 214 226 67 241 220 142 11 148 205 196 96 27 73 68 221 70 186 85 124 146 92 127 75 187 162 216 168 40 179 56 178 36 227 231 168 145 189 63 120 187 192 250 79 23 144 169 121 52 226 111 36 68 35 60 68 184 130 80 39 55 71 88 213 184 91 64 3 126 81 119 111 54 77 30 189 126 231 62 105 164 58 31 114 158 188 240 118 226 57 232 6 40 224 143 37 226 251 143 203 61 60 17 96 217 70 118 80 251 40 255 110 142 231 237 25 29 74 199 195 97 82 174 59 200 114 200 95 75 251 81 39 182 236 28 164 203 78 217 130 151 244 206 50 23 237 213 39 105 186 227 121 201 156 218 186 123 59 49 49 44 75 32 44 84 91 160 84 40 206 236 34 134 254 132 4 116 31 35 11 243 253 31 112 203 77 58 5 40 127 209 192 217 162 25 160 201 171 195 118 121 243 204 152 78 191 187 93 116 233 50 142 35 114 146 178 121 178 247 167 241 164 8 28 113 165 140 208 5 129 104 15 177 181 105 48 243 0 24 39 215 63 235 197 174 18 254 96 102 88 186 5 198 197 138 99 60 133 136 151 217 240 218 118 175 147 118 207 195 184 163 203 237 7 60 64 185 105 157 3 209 189 77 34 41 63 224 255 179 57 120 222 237 10 96 249 39 177 233 128 186 243 180 96 172 155 97 39 135 77 166 230 202 175 189 63 219 90 88 243 159 170 97 195 55 111 33 173 154 208 95 170 84 183 28 207 84 136 103 191 253 235 181 18 234 67 95 123 169 157 3 100 93 153 37 132 142 180 216 214 229 113 179 245 98 130 153 66 72 73 119 59 85 43 20 135 66 230 243 195 59 139 27 248 198 143 134 27 87 41 210 6 17 117 203 123 89 186 133 203 180 214 73 154 239 138 51 103 254 11 221 127 212 209 250 208 253 78 85 40 207 6 86 249 41 133 14 78 246 84 182 255 233 114 90 238 210 167 187 91 137 100 46 71 186 123 210 86 10 3 107 167 191 160 45 4 251 131 16 174 73 86 181 101 215 189 155 157 177 159 131 52 186 145 130 119 235 153 147 10 48 215 198 253 100 251 211 126 113 14 254 142 203 225 138 160 115 106 119 75 89 63 91 218 23 209 215 166 10 133 215 138 9 187 87 64 67 198 180 115 208 65 72 39 25 192 15 246 40 17 250 168 138 51 212 196 26 93 152 99 252 25 34 21 238 15 251 17 77 187 205 167 125 254 209 155 55 253 216 241 172 242 161 176 126 170 25 184 2 41 250 217 85 143 192 148 254 105 8 90 93 154 57 184 125 145 14 129 22 255 8 -1646290518
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
