*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 145 72 30 32 100 18 24 187 51 25 6 108 234 39 89 252 140 181 102 82 243 64 132 179 147 102 250 94 232 10 238 234 48 35 151 137 72 145 27 195 0 127 78 101 165 95 22 42 105 5 16 87 227 166 153 98 248 30 72 82 14 228 68 208 88 2 238 78 37 129 17 18 192 10 68 167 246 66 79 1 253 142 167 122 80 32 193 42 134 54 192 239 194 102 18 220 134 111 244 101 240 202 124 114 152 17 183 165 245 156 8 232 241 165 22 39 57 93 239 130 140 30 89 53 232 162 255 232 82 103 248 91 45 69 178 19 196 29 64 118 192 97 253 6 213 218 61 84 167 142 74 146 131 221 194 217 120 122 144 218 170 147 14 75 225 154 12 81 229 0 176 177 107 90 143 77 186 52 235 124 22 28 86 195 91 46 128 2 133 240 207 177 115 17 249 13 132 43 33 226 200 157 145 156 222 33 68 130 132 74 101 188 239 214 41 176 216 145 72 133 150 78 164 131 178 16 108 176 74 36 247 134 67 108 121 70 144 38 48 243 153 53 197 129 204 1 146 20 7 223 160 71 78 236 19 87 5 235 101 77 106 5 81 67 223 204 138 62 181 228 190 74 2 99 172 92 100 145 111 108 15 74 21 188 49 198 17 196 66 50 244 93 155 234 96 190 239 161 18 121 92 34 25 234 201 36 165 244 87 185 127 215 50 100 243 76 150 24 85 77 53 45 172 189 223 217 181 20 249 103 34 234 37 250 73 89 101 168 232 158 120 116 233 14 225 170 244 124 188 187 18 107 231 113 208 6 90 133 120 147 219 61 57 186 66 80 103 237 25 249 157 202 137 21 212 93 211 1 48 114 194 229 77 252 168 73 129 71 15 144 62 13 25 17 103 194 108 128 33 52 156 61 209 64 158 209 4 6 144 167 63 252 192 22 207 138 163 188 53 148 235 99 218 70 216 4 53 129 239 200 75 87 162 200 152 78 220 65 119 110 227 0 210 184 135 152 31 106 183 118 6 203 122 253 250 179 11 235 222 230 210 122 36 10 196 127 17 100 207 209 161 7 71 218 249 107 137 251 81 163 32 140 170 96 191 215 117 55 18 180 252 62 216 120 37 234 126 53 65 30 190 76 215 128 60 138 135 35 179 42 249 22 48 248 153 166 54 182 186 14 117 132 195 146 23 178 90 250 95 134 114 231 58 255 38 85 173 117 107 28 64 14 48 39 102 231 30 226 63 230 37 177 74 137 161 154 182 44 209 19 197 105 188 210 101 225 151 120 201 99 205 31 119 133 58 214 203 224 68 2 95 19 230 211 20 19 60 165 0 117 47 141 168 149 79 151 145 147 243 251 182 223 223 157 199 242 3 189 212 18 205 139 100 120 36 88 64 76 149 221 52 203 176 95 117 20 87 149 165 222 215 126 1 2 181 52 1 58 150 135 142 27 84 30 106 156 26 170 31 134 163 216 208 202 71 90 97 62 183 187 221 88 11 95 128 134 45 114 47 46 32 132 4 137 238 165 94 88 56 22 38 94 239 36 226 173 136 157 170 91 104 58 60 51 125 211 107 98 206 7 50 61 187 84 93 42 82 222 32 219 147 182 162 13 208 159 28 101 129 101 109 157 15 179 241 181 167 72 188 164 59 62 250 192 164 72 244 183 78 4 163 157 249 27 10 81 117 38 190 118 16 97 17 7 176 203 53 216 83 55 243 44 78 101 0 123 53 145 250 105 47 210 194 246 128 176 189 119 234 206 64 168 66 6 78 34 80 244 122 101 236 227 204 195 228 113 154 23 36 123 238 54 242 164 223 87 136 254 24 93 145 199 240 209 78 79 214 28 166 242 71 3 2 251 190 241 204 0 207 194 170 100 70 132 57 18 152 136 144 9 119 12 101 127 214 36 47 112 172 138 35 8 206 127 88 177 245 191 9 244 227 122 94 167 197 130 129 113 113 222 155 133 134 196 139 40 255 80 21 244 36 34 169 136 60 234 240 187 20 79 162 53 52 237 172 188 84 56 38 159 141 100 157 33 127 181 34 137 222 245 101 157 28 139 31 69 55 147 185 163 109 83 119 185 69 217 207 15 236 203 3 168 19 211 1 155 57 155 86 59 86 165 155 40 76 187 65 149 111 109 218 63 72 177 195 212 214 14 252 54 17 131 147 241 147 172 205 247 188 1 118 93 201 255 90 198 2 104 163 11 223 34 195 66 87 203 53 212 33 134 174 4 68 5 239 142 26 199 182 52 -1796329380
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
